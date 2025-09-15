import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:talker/talker.dart';
import 'package:talker_grpc_logger/src/grpc_logs.dart';
import 'package:talker_grpc_logger/talker_grpc_logger.dart';
import 'package:test/test.dart';

/// Minimal fake ClientCall that lets us drive a ResponseFuture/ResponseStream.
class _FakeClientCall<R> extends ClientCall<dynamic, R> {
  _FakeClientCall(ClientMethod<dynamic, R> method, CallOptions options)
      : _responses = StreamController<R>(),
        _headersC = Completer<Map<String, String>>(),
        _trailersC = Completer<Map<String, String>>(),
        super(method, const Stream<dynamic>.empty(), options);

  final StreamController<R> _responses;
  final Completer<Map<String, String>> _headersC;
  final Completer<Map<String, String>> _trailersC;

  // Test helpers to complete the call
  void succeed(R value,
      {Map<String, String> headers = const {},
      Map<String, String> trailers = const {}}) {
    if (!_headersC.isCompleted) _headersC.complete(headers);
    if (!_trailersC.isCompleted) _trailersC.complete(trailers);
    _responses.add(value);
    _responses.close();
  }

  void fail(Object error, [StackTrace? st]) {
    if (!_headersC.isCompleted) _headersC.complete({});
    if (!_trailersC.isCompleted) _trailersC.complete({});
    _responses.addError(error, st);
    _responses.close();
  }

  @override
  Stream<R> get response => _responses.stream;

  @override
  Future<Map<String, String>> get headers => _headersC.future;

  @override
  Future<Map<String, String>> get trailers => _trailersC.future;

  @override
  Future<void> cancel() async {
    await _responses.close();
  }
}

/// ResponseFuture factory for tests (success).
ResponseFuture<R> _responseFutureOk<R>(
  ClientMethod<dynamic, R> method,
  CallOptions options,
  R value,
) {
  final call = _FakeClientCall<R>(method, options);
  // Complete asynchronously to mimic real network behavior
  scheduleMicrotask(() => call.succeed(value));
  return ResponseFuture<R>(call);
}

/// ResponseFuture factory for tests (error).
ResponseFuture<R> _responseFutureErr<R>(
  ClientMethod<dynamic, R> method,
  CallOptions options,
  GrpcError error,
) {
  final call = _FakeClientCall<R>(method, options);
  scheduleMicrotask(() => call.fail(error));
  return ResponseFuture<R>(call);
}

/// ResponseStream factory for tests (single value).
ResponseStream<R> _responseStream<R>(
  ClientMethod<dynamic, R> method,
  CallOptions options, {
  required Stream<R> stream,
}) {
  // Pipe the provided stream through FakeClientCall
  final call = _FakeClientCall<R>(method, options);
  // Forward items
  stream.listen(
    (v) => call.succeed(v),
    onError: (e, st) => call.fail(e, st),
    onDone: () {},
    cancelOnError: false,
  );
  return ResponseStream<R>(call);
}

/// Talker that captures logs passed via logCustom.
class _CapturingTalker extends Talker {
  final List<TalkerLog> captured = [];

  @override
  void logCustom(Object obj) {
    if (obj is TalkerLog) {
      captured.add(obj);
    } else {
      super.log(obj.toString());
    }
  }
}

void main() {
  group('TalkerGrpcLogger.interceptUnary', () {
    late ClientMethod<String, String> method;
    late _CapturingTalker talker;

    setUp(() {
      method = ClientMethod<String, String>(
        '/TestService/TestUnary',
        (s) => List<int>.from(s.codeUnits),
        (l) => String.fromCharCodes(l),
      );
      talker = _CapturingTalker();
    });

    test('logs request first and response second on success; returns value',
        () async {
      final logger = TalkerGrpcLogger(talker: talker, obfuscateToken: true);

      final options = CallOptions(
        metadata: {
          'authorization': 'Bearer token-123', // should be obfuscated
          'x-id': 'abc',
        },
      );

      // Invoker that returns a real ResponseFuture (success).
      invoker(ClientMethod<String, String> m, String req, CallOptions opt) {
        expect(m, same(method));
        expect(req, 'ping');
        return _responseFutureOk<String>(
            m as ClientMethod<dynamic, String>, opt, 'OK');
      }

      final result = await logger.interceptUnary<String, String>(
        method,
        'ping',
        options,
        invoker,
      );

      expect(result, 'OK');

      // Two logs: request -> response.
      expect(talker.captured.length, 2);
      expect(talker.captured[0], isA<GrpcRequestLog<String, String>>());
      expect(talker.captured[1], isA<GrpcResponseLog<String, String>>());

      final reqMsg = (talker.captured[0] as GrpcRequestLog<String, String>)
          .generateTextMessage();
      expect(reqMsg, contains('[${method.path}]'));
      expect(reqMsg, contains('Request: ping'));
      expect(reqMsg, contains('"authorization": "Bearer [obfuscated]"'));
      expect(reqMsg, contains('"x-id": "abc"'));

      final resMsg = (talker.captured[1] as GrpcResponseLog<String, String>)
          .generateTextMessage();
      expect(resMsg, contains('[${method.path}]'));
      expect(resMsg, contains('Duration: '));
    });

    test(
        'logs request first and error second on failure; rethrows the same GrpcError',
        () async {
      final logger = TalkerGrpcLogger(talker: talker, obfuscateToken: true);

      final options = CallOptions(
        metadata: {'Authorization': 'Bearer SECRET'},
      );
      final error = GrpcError.unavailable('Service down');

      // Invoker that returns a real ResponseFuture (error).
      invoker(ClientMethod<String, String> m, String req, CallOptions opt) {
        return _responseFutureErr<String>(
            m as ClientMethod<dynamic, String>, opt, error);
      }

      await expectLater(
        logger.interceptUnary<String, String>(
            method, 'payload', options, invoker),
        throwsA(same(error)),
      );

      // Two logs: request -> error.
      expect(talker.captured.length, 2);
      expect(talker.captured[0], isA<GrpcRequestLog<String, String>>());
      expect(talker.captured[1], isA<GrpcErrorLog<String, String>>());

      final errMsg = (talker.captured[1] as GrpcErrorLog<String, String>)
          .generateTextMessage();
      expect(errMsg, contains('[${method.path}]'));
      expect(errMsg, contains('Error code: UNAVAILABLE'));
      expect(errMsg, contains('Error message: Service down'));
      expect(errMsg, contains('"Authorization": "Bearer [obfuscated]"'));
    });

    test('obfuscation OFF propagates into request and error logs', () async {
      final logger = TalkerGrpcLogger(talker: talker, obfuscateToken: false);

      final options = CallOptions(metadata: {'authorization': 'Bearer PLAIN'});

      // Success path to inspect request log.
      okInvoker(ClientMethod<String, String> m, String req, CallOptions opt) {
        return _responseFutureOk<String>(
            m as ClientMethod<dynamic, String>, opt, 'OK');
      }

      await logger.interceptUnary<String, String>(
          method, 'data', options, okInvoker);

      final reqLog = talker.captured.firstWhere(
        (e) => e is GrpcRequestLog<String, String>,
      ) as GrpcRequestLog<String, String>;

      final reqMsg = reqLog.generateTextMessage();
      expect(reqMsg, contains('"authorization": "Bearer PLAIN"'));
      expect(reqMsg, isNot(contains('[obfuscated]')));

      // Error path with same logger (still obfuscation OFF).
      final err = GrpcError.permissionDenied('nope');
      errInvoker(ClientMethod<String, String> m, String req, CallOptions opt) {
        return _responseFutureErr<String>(
            m as ClientMethod<dynamic, String>, opt, err);
      }

      await expectLater(
        logger.interceptUnary<String, String>(
            method, 'data', options, errInvoker),
        throwsA(same(err)),
      );

      final errLog = talker.captured.lastWhere(
        (e) => e is GrpcErrorLog<String, String>,
      ) as GrpcErrorLog<String, String>;

      final errMsg = errLog.generateTextMessage();
      expect(errMsg, contains('"authorization": "Bearer PLAIN"'));
      expect(errMsg, contains('Error code: PERMISSION_DENIED'));
    });

    test('returns exactly what invoker returns (pass-through semantics)',
        () async {
      final logger = TalkerGrpcLogger(talker: talker);

      invoker(ClientMethod<String, String> m, String req, CallOptions opt) {
        return _responseFutureOk<String>(
            m as ClientMethod<dynamic, String>, opt, 'RESULT');
      }

      final res = await logger.interceptUnary<String, String>(
          method, 'x', CallOptions(), invoker);
      expect(res, 'RESULT');
    });
  });

  group('TalkerGrpcLogger.interceptStreaming', () {
    late ClientMethod<String, String> method;

    setUp(() {
      method = ClientMethod<String, String>(
        '/TestService/Stream',
        (s) => List<int>.from(s.codeUnits),
        (l) => String.fromCharCodes(l),
      );
    });

    test('forwards to invoker and returns the same ResponseStream', () async {
      final talker = _CapturingTalker();
      final logger = TalkerGrpcLogger(talker: talker);

      ClientMethod<String, String>? receivedMethod;
      CallOptions? receivedOptions;

      invoker(
        ClientMethod<String, String> m,
        Stream<String> reqs,
        CallOptions opt,
      ) {
        receivedMethod = m;
        receivedOptions = opt;

        // Return a proper ResponseStream via FakeClientCall
        final out = Stream<String>.value('RESPONSE');
        return _responseStream<String>(
          m as ClientMethod<dynamic, String>,
          opt,
          stream: out,
        );
      }

      final input = Stream<String>.fromIterable(['a', 'b', 'c']);
      final options = CallOptions(metadata: {'x': '1'});

      final outStream = logger.interceptStreaming<String, String>(
          method, input, options, invoker);

      // Invoker received method and options
      expect(receivedMethod, same(method));
      expect(receivedOptions?.metadata, containsPair('x', '1'));

      // Returned stream emits what invoker produced
      final items = await outStream.toList();
      expect(items, equals(['RESPONSE']));

      // No logs recorded for streaming in current implementation
      expect(talker.captured, isEmpty);
    });
  });
}
