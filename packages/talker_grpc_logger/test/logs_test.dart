import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:talker/talker.dart';
import 'package:talker_grpc_logger/src/grpc_logs/grpc_error_log.dart';
import 'package:talker_grpc_logger/src/grpc_logs/grpc_event_log.dart';
import 'package:talker_grpc_logger/src/grpc_logs/grpc_request_log.dart';
import 'package:talker_grpc_logger/src/grpc_logs/grpc_response_log.dart';
import 'package:talker_grpc_logger/src/intercepted_response_stream.dart';
import 'package:talker_grpc_logger/talker_grpc_logger.dart';
import 'package:test/test.dart';

ClientMethod<String, String> createMethod(String path) =>
    ClientMethod<String, String>(
      path,
      (s) => List<int>.from(s.codeUnits),
      (l) => String.fromCharCodes(l),
    );

class _FakeClientCall<R> implements ClientCall<dynamic, R> {
  _FakeClientCall(this._future);

  final Future<R> _future;

  @override
  Stream<R> get response => Stream<R>.fromFuture(_future);

  @override
  Future<void> cancel() async {}

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('Not needed for tests: $invocation');
}

ResponseFuture<R> _responseFuture<R>(Future<R> future) =>
    ResponseFuture<R>(_FakeClientCall<R>(future));

class FakeResponseStream<R> extends Stream<R> implements ResponseStream<R> {
  FakeResponseStream(this._inner);

  final Stream<R> _inner;

  @override
  bool get isBroadcast => false;

  @override
  StreamSubscription<R> listen(
    void Function(R event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      _inner.listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );

  @override
  Future<Map<String, String>> get headers async => const <String, String>{};

  @override
  Future<Map<String, String>> get trailers async => const <String, String>{};

  @override
  ResponseFuture<R> get single => _responseFuture<R>(_inner.single);

  @override
  Future<void> cancel() async {}
}

Future<void> waitFor(
  bool Function() predicate, {
  Duration timeout = const Duration(seconds: 2),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (!predicate()) {
    if (DateTime.now().isAfter(deadline)) {
      fail('waitFor: condition did not become true within $timeout');
    }
    await Future<void>.delayed(const Duration(milliseconds: 1));
  }
}

Future<void> expectNever(
  bool Function() predicate, {
  Duration window = const Duration(milliseconds: 100),
}) async {
  await Future<void>.delayed(window);
  if (predicate()) {
    fail('expectNever: condition became true within $window');
  }
}

/// A [Talker] that records every [TalkerLog] passed to [logCustom].
class _CapturingTalker extends Talker {
  final List<TalkerLog> captured = [];

  @override
  void logCustom(TalkerLog log) {
    captured.add(log);
    super.logCustom(log);
  }
}

void main() {
  group('GrpcRequestLog', () {
    test('key is correct', () {
      final method = createMethod('/TestService/RequestKey');
      final log = GrpcRequestLog<String, String>.unary(
        request: 'hello',
        method: method,
        options: CallOptions(metadata: {}),
      );
      expect(log.key, equals(TalkerKey.grpcRequest));
    });

    test('message contains path and request payload', () {
      final method = createMethod('/TestService/RequestPayload');
      final log = GrpcRequestLog<String, String>.unary(
        request: 'line1\nline2',
        method: method,
        options: CallOptions(metadata: {}),
      );
      final msg = log.generateTextMessage();
      expect(msg, contains(method.path));
      expect(msg, contains('line1'));
      expect(msg, contains('line2'));
      expect(msg, isNot(contains('Headers:')));
    });

    test('hiddenHeaders are replaced with *****', () {
      final method = createMethod('/TestService/RequestHiddenHeaders');
      final log = GrpcRequestLog<String, String>.unary(
        request: 'data',
        method: method,
        options: CallOptions(
          metadata: {
            'Authorization': 'Bearer secret',
            'x-trace-id': '123',
          },
        ),
        settings: const TalkerGrpcLoggerSettings(
          hiddenHeaders: {'Authorization'},
        ),
      );

      final msg = log.generateTextMessage();

      expect(msg, contains('Headers:'));
      expect(msg, contains('*****'));
      expect(msg, isNot(contains('Bearer secret')));
      expect(msg, contains('x-trace-id'));
      expect(msg, contains('123'));
    });

    test('hiddenHeaders matching is case-insensitive', () {
      final method = createMethod('/TestService/RequestHiddenCase');
      final log = GrpcRequestLog<String, String>.unary(
        request: 'data',
        method: method,
        options: CallOptions(
          metadata: {'AUTHORIZATION': 'Bearer secret'},
        ),
        settings: const TalkerGrpcLoggerSettings(
          hiddenHeaders: {'authorization'},
        ),
      );

      final msg = log.generateTextMessage();
      expect(msg, contains('*****'));
      expect(msg, isNot(contains('Bearer secret')));
    });

    test('obfuscation OFF: Authorization is shown in plain text', () {
      final method = createMethod('/TestService/RequestNoObfuscation');
      final log = GrpcRequestLog<String, String>.unary(
        request: 'data',
        method: method,
        options: CallOptions(
          metadata: {'Authorization': 'Bearer abc.def'},
        ),
      );

      final msg = log.generateTextMessage();
      expect(msg, contains('Bearer abc.def'));
      expect(msg, isNot(contains('*****')));
    });

    test('does not add Headers section when metadata is empty', () {
      final method = createMethod('/TestService/RequestNoHeaders');
      final log = GrpcRequestLog<String, String>.unary(
        request: 'data',
        method: method,
        options: CallOptions(metadata: {}),
      );
      final msg = log.generateTextMessage();
      expect(msg, contains(method.path));
      expect(msg, contains('data'));
      expect(msg, isNot(contains('Headers:')));
    });

    test('does not mutate original options.metadata', () {
      final method = createMethod('/TestService/RequestNoMutation');
      final metadata = <String, String>{'Authorization': 'Bearer secret'};
      final log = GrpcRequestLog<String, String>.unary(
        request: 'data',
        method: method,
        options: CallOptions(metadata: metadata),
        settings: const TalkerGrpcLoggerSettings(
          hiddenHeaders: {'authorization'},
        ),
      );

      log.generateTextMessage();
      expect(metadata['Authorization'], equals('Bearer secret'));
    });

    test('stream factory renders Data line for payload', () {
      final method = createMethod('/TestService/RequestStreamFactory');
      final log = GrpcRequestLog<String, String>.stream(
        request: 'stream-item',
        method: method,
        options: CallOptions(metadata: {}),
      );
      final msg = log.generateTextMessage();
      expect(log.key, equals(TalkerKey.grpcRequest));
      expect(msg, contains('stream-item'));
      expect(msg, contains('Data:'));
      expect(msg, contains('[STREAM]'));
      expect(msg, isNot(contains('Event:')));
    });

    test('unary factory uses [UNARY] title', () {
      final method = createMethod('/TestService/RequestUnaryTitle');
      final log = GrpcRequestLog<String, String>.unary(
        request: 'x',
        method: method,
        options: CallOptions(metadata: {}),
      );
      expect(log.generateTextMessage(), contains('[UNARY]'));
    });

    test('printRequestData = false hides payload', () {
      final method = createMethod('/TestService/RequestNoData');
      final log = GrpcRequestLog<String, String>.unary(
        request: 'secret-payload',
        method: method,
        options: CallOptions(metadata: {}),
        settings: const TalkerGrpcLoggerSettings(printRequestData: false),
      );
      expect(log.generateTextMessage(), isNot(contains('secret-payload')));
    });

    test('printRequestHeaders = false hides headers', () {
      final method = createMethod('/TestService/RequestNoHeadersFlag');
      final log = GrpcRequestLog<String, String>.unary(
        request: 'x',
        method: method,
        options: CallOptions(metadata: {'x-trace-id': '123'}),
        settings: const TalkerGrpcLoggerSettings(printRequestHeaders: false),
      );
      expect(log.generateTextMessage(), isNot(contains('Headers:')));
    });

    test('uses custom pen when provided', () {
      final method = createMethod('/TestService/RequestCustomPen');
      final pen = AnsiPen()..blue();
      final log = GrpcRequestLog<String, String>.unary(
        request: 'x',
        method: method,
        options: CallOptions(metadata: {}),
        settings: TalkerGrpcLoggerSettings(requestPen: pen),
      );
      expect(log.pen, same(pen));
    });

    test('logLevel follows settings.logLevel', () {
      final method = createMethod('/TestService/RequestLogLevel');
      final log = GrpcRequestLog<String, String>.unary(
        request: 'x',
        method: method,
        options: CallOptions(metadata: {}),
        settings: const TalkerGrpcLoggerSettings(logLevel: LogLevel.warning),
      );
      expect(log.logLevel, LogLevel.warning);
    });
  });

  // NEW: GrpcEventLog carries lifecycle markers, no payload.
  group('GrpcEventLog', () {
    test('message contains Event line and never renders Data', () {
      final method = createMethod('/TestService/EventInit');
      final log = GrpcEventLog<String, String>.stream(
        event: 'Stream started',
        method: method,
        options: CallOptions(metadata: {}),
      );
      final msg = log.generateTextMessage();
      expect(msg, contains('[STREAM]'));
      expect(msg, contains('Event: Stream started'));
      expect(msg, isNot(contains('Data:')));
    });

    test('renders no headers and no payload even with payload flags on', () {
      final method = createMethod('/TestService/EventHeaders');
      final log = GrpcEventLog<String, String>.stream(
        event: 'Stream completed (3 responses / 1 request)',
        method: method,
        options: CallOptions(metadata: {'x-trace-id': '123'}),
        settings: const TalkerGrpcLoggerSettings(
          printRequestData: true,
          printResponseData: true,
        ),
      );
      final msg = log.generateTextMessage();
      expect(
          msg, contains('Event: Stream completed (3 responses / 1 request)'));
      expect(msg, isNot(contains('x-trace-id')));
      expect(msg, isNot(contains('Data:')));
    });
  });

  group('GrpcErrorLog', () {
    test('key is correct', () {
      final method = createMethod('/TestService/ErrorKey');
      final log = GrpcErrorLog<String, String>.unary(
        request: 'boom',
        method: method,
        options: CallOptions(metadata: {}),
        grpcError: GrpcError.unavailable('Service down'),
        durationMs: 380,
      );
      expect(log.key, equals(TalkerKey.grpcError));
    });

    test('message contains path, duration, code, message, headers', () {
      final method = createMethod('/TestService/ErrorFullMessage');
      final log = GrpcErrorLog<String, String>.unary(
        request: 'payload',
        method: method,
        options: CallOptions(
          metadata: {
            'Authorization': 'Bearer secret',
            'x-correlation-id': 'corr-1',
          },
        ),
        grpcError: GrpcError.unavailable('Service down'),
        durationMs: 123,
      );

      final msg = log.generateTextMessage();

      expect(msg, contains(method.path));
      expect(msg, contains('Duration: 123 ms'));
      expect(msg, contains('Code: UNAVAILABLE'));
      expect(msg, contains('Message: Service down'));
      expect(msg, contains('Headers:'));
      expect(msg, contains('Authorization'));
      expect(msg, contains('Bearer secret'));
      expect(msg, contains('x-correlation-id'));
      expect(msg, contains('corr-1'));
    });

    test('hiddenHeaders are replaced with *****', () {
      final method = createMethod('/TestService/ErrorHiddenHeaders');
      final log = GrpcErrorLog<String, String>.unary(
        request: 'payload',
        method: method,
        options: CallOptions(
          metadata: {
            'Authorization': 'Bearer secret',
            'x-correlation-id': 'corr-1',
          },
        ),
        grpcError: GrpcError.unavailable('Service down'),
        durationMs: 123,
        settings: const TalkerGrpcLoggerSettings(
          hiddenHeaders: {'Authorization'},
        ),
      );

      final msg = log.generateTextMessage();

      expect(msg, contains('*****'));
      expect(msg, isNot(contains('Bearer secret')));
      expect(msg, contains('corr-1'));
    });

    test('permission denied code is rendered', () {
      final method = createMethod('/TestService/ErrorPermissionDenied');
      final log = GrpcErrorLog<String, String>.unary(
        request: 'payload',
        method: method,
        options: CallOptions(metadata: {}),
        grpcError: GrpcError.permissionDenied('nope'),
        durationMs: 1,
      );

      final msg = log.generateTextMessage();
      expect(msg, contains('Code: PERMISSION_DENIED'));
      expect(msg, contains('Message: nope'));
    });

    test('no Headers section when metadata is empty', () {
      final method = createMethod('/TestService/ErrorNoHeaders');
      final log = GrpcErrorLog<String, String>.unary(
        request: 'x',
        method: method,
        options: CallOptions(metadata: {}),
        grpcError: GrpcError.unknown('x'),
        durationMs: 5,
      );
      expect(log.generateTextMessage(), isNot(contains('Headers:')));
    });

    test('stream factory works and never renders Event line', () {
      final method = createMethod('/TestService/ErrorStreamFactory');
      final log = GrpcErrorLog<String, String>.stream(
        request: 'stream-failed',
        method: method,
        options: CallOptions(metadata: {}),
        grpcError: GrpcError.unavailable('stream down'),
      );
      final msg = log.generateTextMessage();
      expect(log.key, equals(TalkerKey.grpcError));
      expect(msg, contains('Code: UNAVAILABLE'));
      expect(msg, contains('[STREAM]'));
      expect(msg, isNot(contains('Event:')));
    });

    test('printErrorCode = false hides code', () {
      final method = createMethod('/TestService/ErrorNoCode');
      final log = GrpcErrorLog<String, String>.unary(
        request: 'x',
        method: method,
        options: CallOptions(metadata: {}),
        grpcError: GrpcError.unavailable('down'),
        durationMs: 5,
        settings: const TalkerGrpcLoggerSettings(printErrorCode: false),
      );
      final msg = log.generateTextMessage();
      expect(msg, isNot(contains('Code:')));
      expect(msg, contains('Message: down'));
    });

    test('printErrorMessage = false hides message', () {
      final method = createMethod('/TestService/ErrorNoMessage');
      final log = GrpcErrorLog<String, String>.unary(
        request: 'x',
        method: method,
        options: CallOptions(metadata: {}),
        grpcError: GrpcError.unavailable('down'),
        durationMs: 5,
        settings: const TalkerGrpcLoggerSettings(printErrorMessage: false),
      );
      final msg = log.generateTextMessage();
      expect(msg, contains('Code: UNAVAILABLE'));
      expect(msg, isNot(contains('Message:')));
    });

    test('printResponseDuration = false hides duration', () {
      final method = createMethod('/TestService/ErrorNoDuration');
      final log = GrpcErrorLog<String, String>.unary(
        request: 'x',
        method: method,
        options: CallOptions(metadata: {}),
        grpcError: GrpcError.unavailable('down'),
        durationMs: 5,
        settings: const TalkerGrpcLoggerSettings(printResponseDuration: false),
      );
      expect(log.generateTextMessage(), isNot(contains('Duration:')));
    });

    test('logLevel is always error', () {
      final method = createMethod('/TestService/ErrorLogLevel');
      final log = GrpcErrorLog<String, String>.unary(
        request: 'x',
        method: method,
        options: CallOptions(metadata: {}),
        grpcError: GrpcError.unknown('x'),
        durationMs: 1,
        settings: const TalkerGrpcLoggerSettings(logLevel: LogLevel.debug),
      );
      expect(log.logLevel, LogLevel.error);
    });

    test('uses custom pen when provided', () {
      final method = createMethod('/TestService/ErrorCustomPen');
      final pen = AnsiPen()..magenta();
      final log = GrpcErrorLog<String, String>.unary(
        request: 'x',
        method: method,
        options: CallOptions(metadata: {}),
        grpcError: GrpcError.unknown('x'),
        durationMs: 1,
        settings: TalkerGrpcLoggerSettings(errorPen: pen),
      );
      expect(log.pen, same(pen));
    });
  });

  group('GrpcResponseLog', () {
    test('key is correct', () {
      final method = createMethod('/TestService/ResponseKey');
      final log = GrpcResponseLog<String, String>.unary(
        response: 'ok',
        method: method,
        durationMs: 17,
        options: CallOptions(),
      );
      expect(log.key, equals(TalkerKey.grpcResponse));
    });

    test('message contains path, duration and payload', () {
      final method = createMethod('/TestService/ResponseFullMessage');
      final log = GrpcResponseLog<String, String>.unary(
        response: 'OK',
        method: method,
        durationMs: 250,
        options: CallOptions(),
      );
      final msg = log.generateTextMessage();
      expect(msg, contains(method.path));
      expect(msg, contains('Duration: 250 ms'));
      expect(msg, contains('OK'));
    });

    test('hidden response headers are replaced with *****', () {
      final method = createMethod('/TestService/ResponseHiddenHeaders');
      final log = GrpcResponseLog<String, String>.unary(
        response: 'OK',
        method: method,
        durationMs: 10,
        options: CallOptions(metadata: {'set-cookie': 'session=abc'}),
        settings: const TalkerGrpcLoggerSettings(
          hiddenHeaders: {'Set-Cookie'},
        ),
      );

      final msg = log.generateTextMessage();
      expect(msg, contains('*****'));
      expect(msg, isNot(contains('session=abc')));
    });

    test('printResponseData = false hides payload', () {
      final method = createMethod('/TestService/ResponseNoData');
      final log = GrpcResponseLog<String, String>.unary(
        response: 'secret-response',
        method: method,
        durationMs: 10,
        options: CallOptions(),
        settings: const TalkerGrpcLoggerSettings(printResponseData: false),
      );
      final msg = log.generateTextMessage();
      expect(msg, isNot(contains('secret-response')));
      expect(msg, contains('Duration: 10 ms'));
    });

    test('printResponseDuration = false hides duration', () {
      final method = createMethod('/TestService/ResponseNoDuration');
      final log = GrpcResponseLog<String, String>.unary(
        response: 'OK',
        method: method,
        durationMs: 10,
        options: CallOptions(),
        settings: const TalkerGrpcLoggerSettings(printResponseDuration: false),
      );
      expect(log.generateTextMessage(), isNot(contains('Duration:')));
    });

    test('stream factory renders Data line for payload', () {
      final method = createMethod('/TestService/ResponseStreamFactory');
      final log = GrpcResponseLog<String, String>.stream(
        response: 'stream-ok',
        method: method,
        options: CallOptions(),
      );
      final msg = log.generateTextMessage();
      expect(log.key, equals(TalkerKey.grpcResponse));
      expect(msg, contains('Data:'));
      expect(msg, contains('[STREAM]'));
      expect(msg, isNot(contains('Event:')));
    });

    test('uses custom pen when provided', () {
      final method = createMethod('/TestService/ResponseCustomPen');
      final pen = AnsiPen()..yellow();
      final log = GrpcResponseLog<String, String>.unary(
        response: 'x',
        method: method,
        durationMs: 1,
        options: CallOptions(),
        settings: TalkerGrpcLoggerSettings(responsePen: pen),
      );
      expect(log.pen, same(pen));
    });
  });

  group('TalkerGrpcLoggerSettings', () {
    test('default values', () {
      const settings = TalkerGrpcLoggerSettings();
      expect(settings.enabled, isTrue);
      expect(settings.logLevel, LogLevel.debug);
      expect(settings.printRequestData, isTrue);
      expect(settings.printRequestHeaders, isTrue);
      expect(settings.printResponseData, isTrue);
      expect(settings.printResponseHeaders, isTrue);
      expect(settings.printResponseDuration, isTrue);
      expect(settings.printErrorCode, isTrue);
      expect(settings.printErrorHeaders, isTrue);
      expect(settings.printErrorMessage, isTrue);
      expect(settings.printStreamInit, isTrue);
      expect(settings.printStreamChunks, isTrue);
      expect(settings.printStreamComplete, isTrue);
      expect(settings.hiddenHeaders, isEmpty);
    });

    test('copyWith updates fields', () {
      const settings = TalkerGrpcLoggerSettings();
      final copy = settings.copyWith(
        enabled: false,
        logLevel: LogLevel.error,
        printRequestData: false,
        printResponseData: false,
        printStreamInit: false,
        printStreamChunks: false,
        printStreamComplete: false,
        hiddenHeaders: const {'authorization'},
      );
      expect(copy.enabled, isFalse);
      expect(copy.logLevel, LogLevel.error);
      expect(copy.printRequestData, isFalse);
      expect(copy.printResponseData, isFalse);
      expect(copy.printStreamInit, isFalse);
      expect(copy.printStreamChunks, isFalse);
      expect(copy.printStreamComplete, isFalse);
      expect(copy.hiddenHeaders, contains('authorization'));
    });

    test('copyWith without args keeps original values', () {
      const settings = TalkerGrpcLoggerSettings(
        enabled: false,
        logLevel: LogLevel.warning,
        hiddenHeaders: {'authorization'},
      );
      final copy = settings.copyWith();
      expect(copy.enabled, isFalse);
      expect(copy.logLevel, LogLevel.warning);
      expect(copy.hiddenHeaders, contains('authorization'));
    });

    test('equality is value-based', () {
      final a = TalkerGrpcLoggerSettings(hiddenHeaders: {'x'});
      final b = TalkerGrpcLoggerSettings(hiddenHeaders: {'x'});
      expect(a, isNot(same(b)));
      expect(a, equals(b));
    });

    test('logLevel participates in equality', () {
      final a = TalkerGrpcLoggerSettings(logLevel: LogLevel.debug);
      final b = TalkerGrpcLoggerSettings(logLevel: LogLevel.error);
      expect(a, isNot(equals(b)));
    });

    test('stream flags participate in equality', () {
      final a = TalkerGrpcLoggerSettings(printStreamChunks: true);
      final b = TalkerGrpcLoggerSettings(printStreamChunks: false);
      expect(a, isNot(equals(b)));
    });
  });

  group('TalkerGrpcLogger.interceptUnary', () {
    late List<TalkerData> captured;
    late Talker talker;
    late StreamSubscription<TalkerData> sub;

    setUp(() {
      captured = [];
      talker = Talker();
      sub = talker.stream.listen(captured.add);
    });

    tearDown(() async {
      await sub.cancel();
    });

    Iterable<TalkerLog> logsWithKey(String key) =>
        captured.whereType<TalkerLog>().where((l) => l.key == key);

    ClientUnaryInvoker<String, String> makeUnaryInvoker(
      Future<String> response,
    ) {
      final ResponseFuture<String> future = _responseFuture<String>(response);

      ResponseFuture<String> invoker(
        ClientMethod<String, String> _,
        String __,
        CallOptions ___,
      ) =>
          future;

      return invoker;
    }

    test('logs request and response on success', () async {
      final method = createMethod('/TestService/UnarySuccess');
      final logger = TalkerGrpcLogger(talker: talker);

      final rf = logger.interceptUnary<String, String>(
        method,
        'req',
        CallOptions(metadata: const {}),
        makeUnaryInvoker(Future.value('ok')),
      );
      await rf;
      await waitFor(() => logsWithKey(TalkerKey.grpcResponse).isNotEmpty);

      expect(logsWithKey(TalkerKey.grpcRequest), isNotEmpty);
      expect(logsWithKey(TalkerKey.grpcResponse), isNotEmpty);
      expect(logsWithKey(TalkerKey.grpcError), isEmpty);
    });

    test('logs request and error on failure', () async {
      final method = createMethod('/TestService/UnaryFailure');
      final logger = TalkerGrpcLogger(talker: talker);

      final rf = logger.interceptUnary<String, String>(
        method,
        'req',
        CallOptions(metadata: const {}),
        makeUnaryInvoker(Future<String>.error(GrpcError.unavailable('down'))),
      );
      await rf.catchError((_) => '');
      await waitFor(() => logsWithKey(TalkerKey.grpcError).isNotEmpty);

      expect(logsWithKey(TalkerKey.grpcRequest), isNotEmpty);
      expect(logsWithKey(TalkerKey.grpcError), isNotEmpty);
      expect(logsWithKey(TalkerKey.grpcResponse), isEmpty);
    });

    test('does not log when disabled', () async {
      final method = createMethod('/TestService/UnaryDisabled');
      final logger = TalkerGrpcLogger(
        talker: talker,
        settings: const TalkerGrpcLoggerSettings(enabled: false),
      );

      final rf = logger.interceptUnary<String, String>(
        method,
        'req',
        CallOptions(metadata: const {}),
        makeUnaryInvoker(Future.value('ok')),
      );
      await rf;

      await expectNever(
        () =>
            logsWithKey(TalkerKey.grpcRequest).isNotEmpty ||
            logsWithKey(TalkerKey.grpcResponse).isNotEmpty ||
            logsWithKey(TalkerKey.grpcError).isNotEmpty,
      );
      expect(captured, isEmpty);
    });

    test('returns the same ResponseFuture from invoker', () {
      final method = createMethod('/TestService/UnaryPassthrough');
      final logger = TalkerGrpcLogger(
        talker: talker,
        settings: const TalkerGrpcLoggerSettings(enabled: false),
      );

      final ResponseFuture<String> original =
          _responseFuture<String>(Future.value('ok'));

      ResponseFuture<String> invoker(
        ClientMethod<String, String> _,
        String __,
        CallOptions ___,
      ) =>
          original;

      final result = logger.interceptUnary<String, String>(
        method,
        'req',
        CallOptions(),
        invoker,
      );
      expect(identical(result, original), isTrue);
    });
  });

  group('TalkerGrpcLogger.interceptStreaming', () {
    late List<TalkerData> captured;
    late Talker talker;
    late StreamSubscription<TalkerData> sub;

    setUp(() {
      captured = [];
      talker = Talker();
      sub = talker.stream.listen(captured.add);
    });

    tearDown(() async {
      await sub.cancel();
    });

    Iterable<TalkerLog> logsWithKey(String key) =>
        captured.whereType<TalkerLog>().where((l) => l.key == key);

    Iterable<String> textsWithKey(String key) =>
        logsWithKey(key).map((l) => l.generateTextMessage());

    bool hasText(String key, String needle) =>
        textsWithKey(key).any((m) => m.contains(needle));

    // Convenience: events now live under TalkerKey.grpcEvent.
    bool hasEvent(String needle) => hasText(TalkerKey.grpcEvent, needle);

    ResponseStream<String> echoInvoker(
      ClientMethod<String, String> _,
      Stream<String> requests,
      CallOptions __,
    ) {
      final controller = StreamController<String>();
      requests.listen(
        controller.add,
        onDone: controller.close,
        onError: controller.addError,
      );
      return FakeResponseStream<String>(controller.stream);
    }

    ResponseStream<String> failingInvoker(
      ClientMethod<String, String> _,
      Stream<String> __,
      CallOptions ___,
    ) {
      final controller = StreamController<String>();
      Future.microtask(
        () => controller.addError(GrpcError.unavailable('boom')),
      );
      return FakeResponseStream<String>(controller.stream);
    }

    test('logs init + chunks + done by default', () async {
      final method = createMethod('/TestService/StreamInitChunksDone');
      final logger = TalkerGrpcLogger(talker: talker);
      final source = StreamController<String>();

      final ClientStreamingInvoker<String, String> invoker = echoInvoker;

      final stream = logger.interceptStreaming<String, String>(
        method,
        source.stream,
        CallOptions(),
        invoker,
      );

      final resultsFuture = stream.toList();
      source.add('a');
      source.add('b');
      await source.close();

      final results = await resultsFuture;
      await waitFor(() => hasEvent('Event: Stream completed'));

      expect(results, equals(['a', 'b']));

      // 2 request chunks, 2 response chunks.
      expect(logsWithKey(TalkerKey.grpcRequest).length, equals(2));
      expect(logsWithKey(TalkerKey.grpcResponse).length, equals(2));
      // init + done.
      expect(logsWithKey(TalkerKey.grpcEvent).length, equals(2));
      expect(logsWithKey(TalkerKey.grpcError), isEmpty);

      expect(hasEvent('Event: Stream started'), isTrue);
      expect(
        hasEvent('Event: Stream completed (2 responses / 2 requests)'),
        isTrue,
      );
    });

    test('Event and Data never appear in the same entry', () async {
      final method = createMethod('/TestService/StreamEventDataInvariant');
      final logger = TalkerGrpcLogger(talker: talker);
      final source = StreamController<String>();

      final stream = logger.interceptStreaming<String, String>(
        method,
        source.stream,
        CallOptions(),
        echoInvoker,
      );

      final resultsFuture = stream.toList();
      source.add('a');
      source.add('b');
      await source.close();
      await resultsFuture;
      await waitFor(() => hasEvent('Event: Stream completed'));

      for (final log in captured.whereType<TalkerLog>()) {
        final msg = log.generateTextMessage();
        expect(
          msg.contains('Event:') && msg.contains('Data:'),
          isFalse,
          reason: 'Event: and Data: must never appear together, got:\n$msg',
        );
      }
    });

    test('printRequestData = false hides chunks but keeps init Event',
        () async {
      final method = createMethod('/TestService/StreamInitNoData');
      final logger = TalkerGrpcLogger(
        talker: talker,
        settings: const TalkerGrpcLoggerSettings(printRequestData: false),
      );
      final source = StreamController<String>();

      final stream = logger.interceptStreaming<String, String>(
        method,
        source.stream,
        CallOptions(),
        echoInvoker,
      );

      final resultsFuture = stream.toList();
      source.add('secret-payload');
      await source.close();
      await resultsFuture;
      await waitFor(() => hasEvent('Event: Stream completed'));

      expect(hasEvent('Event: Stream started'), isTrue);
      expect(hasText(TalkerKey.grpcRequest, 'secret-payload'), isFalse);
      expect(hasText(TalkerKey.grpcRequest, 'Data:'), isFalse);
    });

    test('printResponseData = false hides chunks but keeps completion Event',
        () async {
      final method = createMethod('/TestService/StreamDoneNoData');
      final logger = TalkerGrpcLogger(
        talker: talker,
        settings: const TalkerGrpcLoggerSettings(printResponseData: false),
      );
      final source = StreamController<String>();

      final stream = logger.interceptStreaming<String, String>(
        method,
        source.stream,
        CallOptions(),
        echoInvoker,
      );

      final resultsFuture = stream.toList();
      source.add('payload');
      await source.close();
      await resultsFuture;
      await waitFor(() => hasEvent('Event: Stream completed'));

      expect(
        hasEvent('Event: Stream completed (1 response / 1 request)'),
        isTrue,
      );
      expect(hasText(TalkerKey.grpcResponse, 'payload'), isFalse);
      expect(hasText(TalkerKey.grpcResponse, 'Data:'), isFalse);
    });

    test('printStreamInit = false suppresses init entry', () async {
      final method = createMethod('/TestService/StreamNoInit');
      final logger = TalkerGrpcLogger(
        talker: talker,
        settings: const TalkerGrpcLoggerSettings(printStreamInit: false),
      );
      final source = StreamController<String>();

      final ClientStreamingInvoker<String, String> invoker = echoInvoker;

      final stream = logger.interceptStreaming<String, String>(
        method,
        source.stream,
        CallOptions(),
        invoker,
      );

      final resultsFuture = stream.toList();
      source.add('a');
      await source.close();
      await resultsFuture;
      await waitFor(() => hasEvent('Event: Stream completed'));

      expect(hasEvent('Event: Stream started'), isFalse);
      // Only the completion event.
      expect(logsWithKey(TalkerKey.grpcEvent).length, 1);
    });

    test('printStreamChunks = false suppresses per-chunk entries only',
        () async {
      final method = createMethod('/TestService/StreamNoChunks');
      final logger = TalkerGrpcLogger(
        talker: talker,
        settings: const TalkerGrpcLoggerSettings(printStreamChunks: false),
      );
      final source = StreamController<String>();

      final ClientStreamingInvoker<String, String> invoker = echoInvoker;

      final stream = logger.interceptStreaming<String, String>(
        method,
        source.stream,
        CallOptions(),
        invoker,
      );

      final resultsFuture = stream.toList();
      source.add('a');
      source.add('b');
      await source.close();
      await resultsFuture;
      await waitFor(() => hasEvent('Event: Stream completed'));

      // No chunk entries, but lifecycle events remain.
      expect(logsWithKey(TalkerKey.grpcRequest), isEmpty);
      expect(logsWithKey(TalkerKey.grpcResponse), isEmpty);
      expect(logsWithKey(TalkerKey.grpcEvent).length, 2);

      expect(hasEvent('Event: Stream started'), isTrue);
      expect(
        hasEvent('Event: Stream completed (2 responses / 2 requests)'),
        isTrue,
      );
    });

    test('printStreamComplete = false suppresses completion entry', () async {
      final method = createMethod('/TestService/StreamNoDone');
      final logger = TalkerGrpcLogger(
        talker: talker,
        settings: const TalkerGrpcLoggerSettings(printStreamComplete: false),
      );
      final source = StreamController<String>();

      final ClientStreamingInvoker<String, String> invoker = echoInvoker;

      final stream = logger.interceptStreaming<String, String>(
        method,
        source.stream,
        CallOptions(),
        invoker,
      );

      final resultsFuture = stream.toList();
      source.add('a');
      await source.close();
      await resultsFuture;
      await waitFor(() => logsWithKey(TalkerKey.grpcEvent).isNotEmpty);
      await expectNever(() => hasEvent('Event: Stream completed'));

      expect(hasEvent('Event: Stream completed'), isFalse);
      // Only the init event.
      expect(logsWithKey(TalkerKey.grpcEvent).length, 1);
    });

    test('completion entry uses singular "response" for a single chunk',
        () async {
      final method = createMethod('/TestService/StreamSingleChunk');
      final logger = TalkerGrpcLogger(talker: talker);
      final source = StreamController<String>();

      final ClientStreamingInvoker<String, String> invoker = echoInvoker;

      final stream = logger.interceptStreaming<String, String>(
        method,
        source.stream,
        CallOptions(),
        invoker,
      );

      final resultsFuture = stream.toList();
      source.add('a');
      await source.close();
      await resultsFuture;
      await waitFor(() => hasEvent('Event: Stream completed'));

      expect(
        hasEvent('Event: Stream completed (1 response / 1 request)'),
        isTrue,
      );
    });

    test('completion entry drops the counter for zero chunks', () async {
      final method = createMethod('/TestService/StreamZeroChunks');
      final logger = TalkerGrpcLogger(talker: talker);

      final ClientStreamingInvoker<String, String> invoker = echoInvoker;

      final stream = logger.interceptStreaming<String, String>(
        method,
        const Stream<String>.empty(),
        CallOptions(),
        invoker,
      );

      await stream.toList();
      await waitFor(() => hasEvent('Event: Stream completed'));

      expect(hasEvent('Event: Stream completed'), isTrue);
      expect(hasEvent('Stream completed ('), isFalse);
    });

    test('logs error when stream fails, no Event line on error', () async {
      final method = createMethod('/TestService/StreamError');
      final logger = TalkerGrpcLogger(talker: talker);

      final ClientStreamingInvoker<String, String> invoker = failingInvoker;

      final stream = logger.interceptStreaming<String, String>(
        method,
        const Stream<String>.empty(),
        CallOptions(),
        invoker,
      );

      await stream.drain<void>().catchError((_) {});
      await waitFor(() => logsWithKey(TalkerKey.grpcError).isNotEmpty);

      expect(logsWithKey(TalkerKey.grpcEvent), isNotEmpty);
      expect(logsWithKey(TalkerKey.grpcError), isNotEmpty);
      expect(hasText(TalkerKey.grpcError, 'Event:'), isFalse);
    });

    test('completion entry is suppressed when stream fails', () async {
      final method = createMethod('/TestService/StreamErrorNoDone');
      final logger = TalkerGrpcLogger(talker: talker);

      final ClientStreamingInvoker<String, String> invoker = failingInvoker;

      final stream = logger.interceptStreaming<String, String>(
        method,
        const Stream<String>.empty(),
        CallOptions(),
        invoker,
      );

      await stream.drain<void>().catchError((_) {});
      await waitFor(() => logsWithKey(TalkerKey.grpcError).isNotEmpty);
      await expectNever(() => hasEvent('Event: Stream completed'));

      expect(hasEvent('Event: Stream completed'), isFalse);
    });

    test('does not log when disabled', () async {
      final method = createMethod('/TestService/StreamDisabled');
      final logger = TalkerGrpcLogger(
        talker: talker,
        settings: const TalkerGrpcLoggerSettings(enabled: false),
      );
      final source = StreamController<String>();

      final ClientStreamingInvoker<String, String> invoker = echoInvoker;

      final stream = logger.interceptStreaming<String, String>(
        method,
        source.stream,
        CallOptions(),
        invoker,
      );

      final resultsFuture = stream.toList();
      source.add('a');
      await source.close();
      await resultsFuture;

      await expectNever(
        () =>
            hasEvent('Event: Stream started') ||
            logsWithKey(TalkerKey.grpcResponse).isNotEmpty ||
            logsWithKey(TalkerKey.grpcError).isNotEmpty,
      );

      expect(captured, isEmpty);
    });

    test('returns the exact stream from invoker when disabled', () {
      final method = createMethod('/TestService/StreamPassthrough');
      final logger = TalkerGrpcLogger(
        talker: talker,
        settings: const TalkerGrpcLoggerSettings(enabled: false),
      );

      final original = FakeResponseStream<String>(const Stream<String>.empty());

      ResponseStream<String> invoker(
        ClientMethod<String, String> _,
        Stream<String> __,
        CallOptions ___,
      ) =>
          original;

      final result = logger.interceptStreaming<String, String>(
        method,
        const Stream<String>.empty(),
        CallOptions(),
        invoker,
      );
      expect(identical(result, original), isTrue);
    });

    test('single() on client-streaming shape logs response and completion',
        () async {
      final method = createMethod('/TestService/ClientStreamingSingle');
      final logger = TalkerGrpcLogger(talker: talker);
      final source = StreamController<String>();

      ResponseStream<String> invoker(
        ClientMethod<String, String> _,
        Stream<String> requests,
        CallOptions __,
      ) {
        final out = StreamController<String>();
        out.add('summary');
        out.close();
        return FakeResponseStream<String>(out.stream);
      }

      final stream = logger.interceptStreaming<String, String>(
        method,
        source.stream,
        CallOptions(),
        invoker,
      );

      final value = await stream.single;
      expect(value, 'summary');

      await waitFor(() => hasEvent('Event: Stream completed'));

      expect(hasEvent('Event: Stream started'), isTrue);
      expect(hasText(TalkerKey.grpcResponse, 'Data:'), isTrue);
      expect(
        hasEvent('Event: Stream completed (1 response)'),
        isTrue,
      );
    });
  });

  group('TalkerGrpcLogger (capturing talker)', () {
    late _CapturingTalker talker;

    setUp(() {
      talker = _CapturingTalker();
    });

    ClientUnaryInvoker<String, String> makeUnaryInvoker(
      Future<String> response,
    ) {
      final ResponseFuture<String> future = _responseFuture<String>(response);

      ResponseFuture<String> invoker(
        ClientMethod<String, String> _,
        String __,
        CallOptions ___,
      ) =>
          future;

      return invoker;
    }

    test('unary success passes a request log then a response log', () async {
      final method = createMethod('/TestService/CaptureUnarySuccess');
      final logger = TalkerGrpcLogger(talker: talker);

      final rf = logger.interceptUnary<String, String>(
        method,
        'req',
        CallOptions(metadata: const {}),
        makeUnaryInvoker(Future.value('ok')),
      );
      await rf;
      await waitFor(() => talker.captured.length >= 2);

      expect(talker.captured[0].key, equals(TalkerKey.grpcRequest));
      expect(talker.captured[1].key, equals(TalkerKey.grpcResponse));

      final reqMsg = talker.captured[0].generateTextMessage();
      expect(reqMsg, contains(method.path));
      expect(reqMsg, contains('[UNARY]'));

      final resMsg = talker.captured[1].generateTextMessage();
      expect(resMsg, contains(method.path));
      expect(resMsg, contains('Duration:'));
    });

    test('unary failure passes a request log then an error log', () async {
      final method = createMethod('/TestService/CaptureUnaryFailure');
      final logger = TalkerGrpcLogger(talker: talker);

      final rf = logger.interceptUnary<String, String>(
        method,
        'req',
        CallOptions(metadata: const {}),
        makeUnaryInvoker(Future<String>.error(GrpcError.unavailable('down'))),
      );
      await rf.catchError((_) => '');
      await waitFor(() => talker.captured.length >= 2);

      expect(talker.captured[0].key, equals(TalkerKey.grpcRequest));
      expect(talker.captured[1].key, equals(TalkerKey.grpcError));

      final errMsg = talker.captured[1].generateTextMessage();
      expect(errMsg, contains('Code: UNAVAILABLE'));
      expect(errMsg, contains('Message: down'));
    });

    test('streaming passes init / chunk / done logs in order', () async {
      final method = createMethod('/TestService/CaptureStreaming');
      final logger = TalkerGrpcLogger(talker: talker);
      final source = StreamController<String>();

      ResponseStream<String> invoker(
        ClientMethod<String, String> _,
        Stream<String> requests,
        CallOptions __,
      ) {
        final controller = StreamController<String>();
        requests.listen(
          controller.add,
          onDone: controller.close,
          onError: controller.addError,
        );
        return FakeResponseStream<String>(controller.stream);
      }

      final stream = logger.interceptStreaming<String, String>(
        method,
        source.stream,
        CallOptions(),
        invoker,
      );

      final resultsFuture = stream.toList();
      source.add('a');
      await source.close();
      await resultsFuture;
      await waitFor(
        () => talker.captured.any(
          (l) =>
              l.key == TalkerKey.grpcEvent &&
              l.generateTextMessage().contains('Event: Stream completed'),
        ),
      );

      // Events: init + done.
      final eventLogs =
          talker.captured.where((l) => l.key == TalkerKey.grpcEvent).toList();
      expect(eventLogs.length, 2);
      expect(
        eventLogs[0].generateTextMessage(),
        contains('Event: Stream started'),
      );
      expect(
        eventLogs[1].generateTextMessage(),
        contains('Event: Stream completed (1 response / 1 request)'),
      );

      // Chunks.
      final requestLogs =
          talker.captured.where((l) => l.key == TalkerKey.grpcRequest).toList();
      expect(requestLogs.length, 1);
      final chunkMsg = requestLogs[0].generateTextMessage();
      expect(chunkMsg, contains('Data:'));
      expect(chunkMsg, contains('a'));
      expect(chunkMsg, isNot(contains('Event:')));

      final responseLogs = talker.captured
          .where((l) => l.key == TalkerKey.grpcResponse)
          .toList();
      expect(responseLogs.length, 1);
      final chunkResMsg = responseLogs[0].generateTextMessage();
      expect(chunkResMsg, contains('Data:'));
      expect(chunkResMsg, contains('a'));
      expect(chunkResMsg, isNot(contains('Event:')));
    });

    test('streaming failure passes an error log without Event line', () async {
      final method = createMethod('/TestService/CaptureStreamingFailure');
      final logger = TalkerGrpcLogger(talker: talker);

      ResponseStream<String> invoker(
        ClientMethod<String, String> _,
        Stream<String> __,
        CallOptions ___,
      ) {
        final controller = StreamController<String>();
        Future.microtask(
          () => controller.addError(GrpcError.unavailable('boom')),
        );
        return FakeResponseStream<String>(controller.stream);
      }

      final stream = logger.interceptStreaming<String, String>(
        method,
        const Stream<String>.empty(),
        CallOptions(),
        invoker,
      );

      await stream.drain<void>().catchError((_) {});
      await waitFor(
        () => talker.captured.any((l) => l.key == TalkerKey.grpcError),
      );

      final errorLog =
          talker.captured.firstWhere((l) => l.key == TalkerKey.grpcError);
      final msg = errorLog.generateTextMessage();
      expect(msg, contains('Code: UNAVAILABLE'));
      expect(msg, contains('Message: boom'));
      expect(msg, isNot(contains('Event:')));
    });

    test('disabled logger produces no captured logs', () async {
      final method = createMethod('/TestService/CaptureDisabled');
      final logger = TalkerGrpcLogger(
        talker: talker,
        settings: const TalkerGrpcLoggerSettings(enabled: false),
      );

      final rf = logger.interceptUnary<String, String>(
        method,
        'req',
        CallOptions(metadata: const {}),
        makeUnaryInvoker(Future.value('ok')),
      );
      await rf;

      await expectNever(
        () =>
            talker.captured.any((l) => l.key == TalkerKey.grpcRequest) ||
            talker.captured.any((l) => l.key == TalkerKey.grpcResponse) ||
            talker.captured.any((l) => l.key == TalkerKey.grpcEvent) ||
            talker.captured.any((l) => l.key == TalkerKey.grpcError),
      );

      expect(talker.captured, isEmpty);
    });
  });

  group('InterceptedResponseStream', () {
    test('forwards data and invokes onResponse', () async {
      final controller = StreamController<String>();
      final received = <String>[];
      final errors = <Object>[];

      final stream = InterceptedResponseStream<String>(
        FakeResponseStream<String>(controller.stream),
        onResponse: received.add,
        onError: errors.add,
      );

      final collected = <String>[];
      stream.listen(collected.add);

      controller.add('a');
      controller.add('b');
      await controller.close();
      await Future<void>.delayed(Duration.zero);

      expect(collected, equals(['a', 'b']));
      expect(received, equals(['a', 'b']));
      expect(errors, isEmpty);
    });

    test('onResponse fires through toList', () async {
      final controller = StreamController<String>();
      final received = <String>[];

      final stream = InterceptedResponseStream<String>(
        FakeResponseStream<String>(controller.stream),
        onResponse: received.add,
        onError: (_) {},
      );

      final resultsFuture = stream.toList();
      controller.add('a');
      controller.add('b');
      await controller.close();
      final results = await resultsFuture;

      expect(results, equals(['a', 'b']));
      expect(received, equals(['a', 'b']));
    });

    test('onResponse fires through drain', () async {
      final controller = StreamController<String>();
      final received = <String>[];

      final stream = InterceptedResponseStream<String>(
        FakeResponseStream<String>(controller.stream),
        onResponse: received.add,
        onError: (_) {},
      );

      final drainedFuture = stream.drain<void>();
      controller.add('a');
      await controller.close();
      await drainedFuture;

      expect(received, equals(['a']));
    });

    test('onComplete fires through drain', () async {
      final controller = StreamController<String>();
      var completed = 0;

      final stream = InterceptedResponseStream<String>(
        FakeResponseStream<String>(controller.stream),
        onResponse: (_) {},
        onError: (_) {},
        onComplete: () => completed++,
      );

      final drainedFuture = stream.drain<void>();
      await controller.close();
      await drainedFuture;

      expect(completed, 1);
    });

    test('calls onError and forwards error to listener', () async {
      final controller = StreamController<String>();
      final errors = <Object>[];
      final caught = <Object>[];

      final stream = InterceptedResponseStream<String>(
        FakeResponseStream<String>(controller.stream),
        onResponse: (_) {},
        onError: errors.add,
      );

      stream.listen((_) {}, onError: caught.add);

      controller.addError(GrpcError.unavailable('x'));
      await controller.close();
      await Future<void>.delayed(Duration.zero);

      expect(errors, hasLength(1));
      expect(caught, hasLength(1));
      expect(caught.first, isA<GrpcError>());
    });

    test('forwards onDone', () async {
      var done = false;
      final controller = StreamController<String>();

      final stream = InterceptedResponseStream<String>(
        FakeResponseStream<String>(controller.stream),
        onResponse: (_) {},
        onError: (_) {},
      );

      stream.listen((_) {}, onDone: () => done = true);
      await controller.close();
      await Future<void>.delayed(Duration.zero);

      expect(done, isTrue);
    });

    test('onComplete fires on done', () async {
      final controller = StreamController<String>();
      var completed = 0;

      final stream = InterceptedResponseStream<String>(
        FakeResponseStream<String>(controller.stream),
        onResponse: (_) {},
        onError: (_) {},
        onComplete: () => completed++,
      );

      stream.listen((_) {});
      await controller.close();
      await Future<void>.delayed(Duration.zero);

      expect(completed, 1);
    });

    test('onComplete is NOT called on cancel', () async {
      final controller = StreamController<String>();
      var completed = 0;

      final stream = InterceptedResponseStream<String>(
        FakeResponseStream<String>(controller.stream),
        onResponse: (_) {},
        onError: (_) {},
        onComplete: () => completed++,
      );

      final subscription = stream.listen((_) {});
      await subscription.cancel();
      await controller.close();
      await Future<void>.delayed(Duration.zero);

      expect(completed, 0);
    });

    test('onComplete is safe when not provided', () async {
      final controller = StreamController<String>();

      final stream = InterceptedResponseStream<String>(
        FakeResponseStream<String>(controller.stream),
        onResponse: (_) {},
        onError: (_) {},
      );

      stream.listen((_) {});
      await controller.close();
      await Future<void>.delayed(Duration.zero);
    });

    test('cancel delegates to original stream', () async {
      final controller = StreamController<String>();
      final stream = InterceptedResponseStream<String>(
        FakeResponseStream<String>(controller.stream),
        onResponse: (_) {},
        onError: (_) {},
      );

      final subscription = stream.listen((_) {});
      expect(controller.hasListener, isTrue);

      await subscription.cancel();
      await Future<void>.delayed(Duration.zero);

      expect(controller.hasListener, isFalse);
      await controller.close();
    });

    test('onResponse is not called when source is empty', () async {
      final controller = StreamController<String>();
      final received = <String>[];

      final stream = InterceptedResponseStream<String>(
        FakeResponseStream<String>(controller.stream),
        onResponse: received.add,
        onError: (_) {},
      );

      stream.listen((_) {});
      await controller.close();
      await Future<void>.delayed(Duration.zero);

      expect(received, isEmpty);
    });

    test('single() routes through onResponse and onComplete', () async {
      final controller = StreamController<String>();
      final received = <String>[];
      var completed = 0;

      final stream = InterceptedResponseStream<String>(
        FakeResponseStream<String>(controller.stream),
        onResponse: received.add,
        onError: (_) {},
        onComplete: () => completed++,
      );

      final future = stream.single;
      controller.add('only');
      await controller.close();

      expect(await future, 'only');
      expect(received, equals(['only']));
      expect(completed, 1);
    });

    test('single() fires onError and rethrows on failure', () async {
      final controller = StreamController<String>();
      final errors = <Object>[];

      final stream = InterceptedResponseStream<String>(
        FakeResponseStream<String>(controller.stream),
        onResponse: (_) {},
        onError: errors.add,
      );

      final future = stream.single;
      controller.addError(GrpcError.unavailable('boom'));
      await controller.close();

      await expectLater(future, throwsA(isA<GrpcError>()));
      expect(errors, hasLength(1));
      expect(errors.first, isA<GrpcError>());
    });

    test('single() delegates headers to original stream', () async {
      final stream = InterceptedResponseStream<String>(
        FakeResponseStream<String>(Stream.value('only')),
        onResponse: (_) {},
        onError: (_) {},
      );

      final single = stream.single;
      expect(await single, 'only');
      expect(await single.headers, isEmpty);
    });

    test('single() cancel() cancels the underlying subscription', () async {
      final controller = StreamController<String>();
      final stream = InterceptedResponseStream<String>(
        FakeResponseStream<String>(controller.stream),
        onResponse: (_) {},
        onError: (_) {},
      );

      final future = stream.single;
      controller.add('only');
      await controller.close();
      await future;
    });
  });
}
