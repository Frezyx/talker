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
          settings: TalkerDioLoggerSettings(printResponseHeaders: true));

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

    test('onRequest method should hide specific header values in log', () {
      final logger = TalkerDioLogger(
          talker: talker,
          settings: TalkerDioLoggerSettings(
              printRequestHeaders: true,
              hideHeaderValuesForKeys: {'Authorization'}));

      final options = RequestOptions(path: '/test', headers: {
        "firstHeader": "firstHeaderValue",
        "authorization": "bearer super_secret_token",
        "lastHeader": "lastHeaderValue",
      });
      logger.onRequest(options, RequestInterceptorHandler());
      print(talker.history);
      expect(
          talker.history.last.generateTextMessage(),
          '[http-request] [GET] /test\n'
          'Headers: {\n'
          '  "firstHeader": "firstHeaderValue",\n'
          '  "authorization": "*****",\n'
          '  "lastHeader": "lastHeaderValue"\n'
          '}');
    });
  });
}
