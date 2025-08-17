import 'package:grpc/grpc.dart';
import 'package:talker/talker.dart';
import 'package:talker_grpc_logger/src/grpc_logs.dart';
import 'package:test/test.dart';

void main() {
  group('GrpcRequestLog', () {
    late ClientMethod<String, String> method;

    setUp(() {
      method = ClientMethod<String, String>(
        '/TestService/TestUnary',
        // Serializers are not used in logs, dummy ones are fine
        (s) => List<int>.from(s.codeUnits),
        (l) => String.fromCharCodes(l),
      );
    });

    test('key is correct', () {
      final log = GrpcRequestLog<String, String>(
        'grpc-request',
        method: method,
        request: 'hello',
        options: CallOptions(metadata: {}),
      );

      expect(log.key, equals(TalkerKey.grpcRequest));
    });

    test('generates message with path, payload and headers (obfuscation ON)',
        () {
      final log = GrpcRequestLog<String, String>(
        'grpc-request',
        method: method,
        request: 'line1\nline2', // newline should be replaced with space
        options: CallOptions(
          metadata: {
            'authorization': 'Bearer real.token.value',
            'x-trace-id': '123',
          },
        ),
        obfuscateToken: true,
      );

      final msg = log.generateTextMessage();
      // Do not check dynamic timestamp, only invariants
      expect(msg, contains('[${method.path}]'));
      expect(msg, contains('Request: line1 line2')); // newline removed

      // Headers are included
      expect(msg, contains('Headers:'));
      // Authorization should be obfuscated
      expect(msg, contains('"authorization": "Bearer [obfuscated]"'));
      // Other headers remain unchanged
      expect(msg, contains('"x-trace-id": "123"'));
    });

    test('generates message with original Authorization (obfuscation OFF)', () {
      final log = GrpcRequestLog<String, String>(
        'grpc-request',
        method: method,
        request: 'data',
        options: CallOptions(
          metadata: {
            'Authorization': 'Bearer abc.def',
          },
        ),
        obfuscateToken: false,
      );

      final msg = log.generateTextMessage();
      expect(msg, contains('"Authorization": "Bearer abc.def"'));
      expect(msg, isNot(contains('[obfuscated]')));
    });

    test('does not add Headers section when metadata is empty', () {
      final log = GrpcRequestLog<String, String>(
        'grpc-request',
        method: method,
        request: 'data',
        options: CallOptions(metadata: {}),
      );

      final msg = log.generateTextMessage();
      expect(msg, contains('[${method.path}]'));
      expect(msg, contains('Request: data'));
      expect(msg, isNot(contains('Headers:')));
    });
  });

  group('GrpcErrorLog', () {
    late ClientMethod<String, String> method;

    setUp(() {
      method = ClientMethod<String, String>(
        '/TestService/TestUnary',
        (s) => List<int>.from(s.codeUnits),
        (l) => String.fromCharCodes(l),
      );
    });

    test('key is correct', () {
      final log = GrpcErrorLog<String, String>(
        'grpc-error',
        method: method,
        request: 'boom',
        options: CallOptions(metadata: {}),
        grpcError: GrpcError.unavailable('Service down'),
        durationMs: 380,
      );

      expect(log.key, equals(TalkerKey.grpcError));
    });

    test(
        'message contains path, duration, code, error text, payload and headers (obfuscation ON)',
        () {
      final log = GrpcErrorLog<String, String>(
        'grpc-error',
        method: method,
        request: 'payload',
        options: CallOptions(
          metadata: {
            'Authorization': 'Bearer secret',
            'x-correlation-id': 'corr-1',
          },
        ),
        grpcError: GrpcError.unavailable('Service down'),
        durationMs: 123,
        obfuscateToken: true,
      );

      final msg = log.generateTextMessage();

      expect(msg, contains('[${method.path}]'));
      expect(msg, contains('Duration: 123 ms'));

      // Error code and message
      expect(msg, contains('Error code: UNAVAILABLE'));
      expect(msg, contains('Error message: Service down'));

      expect(msg, contains('Request: payload'));

      expect(msg, contains('Headers:'));
      expect(msg, contains('"Authorization": "Bearer [obfuscated]"'));
      expect(msg, contains('"x-correlation-id": "corr-1"'));
    });

    test('obfuscation OFF — Authorization is shown in plain text', () {
      final log = GrpcErrorLog<String, String>(
        'grpc-error',
        method: method,
        request: 'payload',
        options: CallOptions(
          metadata: {'authorization': 'Bearer OPEN'},
        ),
        grpcError: GrpcError.permissionDenied('nope'),
        durationMs: 1,
        obfuscateToken: false,
      );

      final msg = log.generateTextMessage();
      expect(msg, contains('"authorization": "Bearer OPEN"'));
      expect(msg, isNot(contains('[obfuscated]')));
      expect(msg, contains('Error code: PERMISSION_DENIED'));
    });

    test('no Headers section when metadata is empty', () {
      final log = GrpcErrorLog<String, String>(
        'grpc-error',
        method: method,
        request: 'x',
        options: CallOptions(metadata: {}),
        grpcError: GrpcError.unknown('x'),
        durationMs: 5,
      );

      final msg = log.generateTextMessage();
      expect(msg, isNot(contains('Headers:')));
    });
  });

  group('GrpcResponseLog', () {
    late ClientMethod<String, String> method;

    setUp(() {
      method = ClientMethod<String, String>(
        '/TestService/TestUnary',
        (s) => List<int>.from(s.codeUnits),
        (l) => String.fromCharCodes(l),
      );
    });

    test('key is correct', () {
      final log = GrpcResponseLog<String, String>(
        'grpc-response',
        method: method,
        response: 'ok',
        durationMs: 17,
      );

      expect(log.key, equals(TalkerKey.grpcResponse));
    });

    test('message contains path and duration (response payload is not logged)',
        () {
      final log = GrpcResponseLog<String, String>(
        'grpc-response',
        method: method,
        response: 'OK',
        durationMs: 250,
      );

      final msg = log.generateTextMessage();
      expect(msg, contains('[${method.path}]'));
      expect(msg, contains('Duration: 250 ms'));
      expect(msg, isNot(contains('OK'))); // response should not appear
    });
  });
}
