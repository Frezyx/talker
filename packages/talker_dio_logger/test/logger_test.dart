import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/dio_logs.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerDioLogger tests', () {
    late TalkerDioLogger logger;
    late Talker talker;

    setUp(() {
      talker = Talker(settings: TalkerSettings(useConsoleLogs: false));
      logger = TalkerDioLogger(talker: talker);
    });

    test('configure method should update logger settings', () {
      logger.configure(printRequestData: true);
      expect(logger.settings.printRequestData, true);
    });

    test('onRequest method should log http request', () {
      final options = RequestOptions(path: '/test');
      final logMessage = '${options.uri}';
      logger.onRequest(options, RequestInterceptorHandler());
      expect(talker.history.last.message, logMessage);
    });

    test('onResponse method should log http response', () {
      final options = RequestOptions(path: '/test');
      final response = Response(requestOptions: options, statusCode: 200);
      final logMessage = '${response.requestOptions.uri}';
      logger.onResponse(response, ResponseInterceptorHandler());
      expect(talker.history.last.message, logMessage);
    });

    test('onError should log DioErrorLog', () async {
      final talker = Talker();
      final logger = TalkerDioLogger(talker: talker);
      final dio = Dio();
      dio.interceptors.add(logger);

      try {
        await dio.get('asdsada');
      } catch (_) {}
      expect(talker.history, isNotEmpty);
      expect(talker.history.last, isA<DioErrorLog>());
    });

    test('onResponse method should log http response headers', () {
      final logger = TalkerDioLogger(
        talker: talker,
        settings: TalkerDioLoggerSettings(printResponseHeaders: true),
      );

      final options = RequestOptions(path: '/test');
      final response = Response(
          requestOptions: options,
          statusCode: 200,
          headers: Headers()..add("HEADER", "VALUE"));
      logger.onResponse(response, ResponseInterceptorHandler());
      expect(
          talker.history.last.generateTextMessage(),
          '[http-response] [GET] /test\n'
          'Status: 200\n'
          'Headers: {\n'
          '  "HEADER": [\n'
          '    "VALUE"\n'
          '  ]\n'
          '}');
    });

    test('onRequest method should hide specific header values in logging', () {
      final logger = TalkerDioLogger(
        talker: talker,
        settings: TalkerDioLoggerSettings(
          printRequestHeaders: true,
          hiddenHeaders: {'Authorization'},
        ),
      );

      final options = RequestOptions(path: '/test', headers: {
        "firstHeader": "firstHeaderValue",
        "authorization": "bearer super_secret_token",
        "lastHeader": "lastHeaderValue",
      });
      logger.onRequest(options, RequestInterceptorHandler());
      final message = talker.history.last.generateTextMessage();
      expect(
          message,
          '[http-request] [GET] /test\n'
          'Headers: {\n'
          '  "firstHeader": "firstHeaderValue",\n'
          '  "authorization": "*****",\n'
          '  "lastHeader": "lastHeaderValue"\n'
          '}');
    });

    test('onRequest method should log extra params if enabled', () {
      final logger = TalkerDioLogger(
        talker: talker,
        settings: TalkerDioLoggerSettings(printRequestExtra: true),
      );
      const extra = {
        "key1": "value",
        "key2": 99,
        "key3": {"nestedKey": "nestedValue"},
        "key4": [1, 2, 3],
        "key5": true,
        "key6": null,
        "key7": 3.14,
        "key8": ["array", "of", "strings"],
      };
      final options = RequestOptions(path: '/test', extra: extra);
      logger.onRequest(options, RequestInterceptorHandler());
      final message = talker.history.last.generateTextMessage();
      expect(
        message,
        contains(
          'Extra: {\n'
          '  "key1": "value",\n'
          '  "key2": 99,\n'
          '  "key3": {\n'
          '    "nestedKey": "nestedValue"\n'
          '  },\n'
          '  "key4": [\n'
          '    1,\n'
          '    2,\n'
          '    3\n'
          '  ],\n'
          '  "key5": true,\n'
          '  "key6": null,\n'
          '  "key7": 3.14,\n'
          '  "key8": [\n'
          '    "array",\n'
          '    "of",\n'
          '    "strings"\n'
          '  ]\n'
          '}',
        ),
      );
    });
  });
}
