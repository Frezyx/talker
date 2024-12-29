import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/dio_logs.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:test/test.dart';

void main() {
  group('DioRequestLog', () {
    test('generateTextMessage should include method and message', () {
      final requestOptions = RequestOptions(path: '/test', method: 'GET');
      final settings = TalkerDioLoggerSettings(
        requestPen: AnsiPen()..blue(),
      );
      final dioRequestLog = DioRequestLog(
        'Test message',
        requestOptions: requestOptions,
        settings: settings,
      );

      final result = dioRequestLog.generateTextMessage();

      expect(result, contains('[GET] Test message'));
    });

    test('generateTextMessage should include data if printRequestData is true',
        () {
      final requestOptions =
          RequestOptions(path: '/test', method: 'POST', data: {'key': 'value'});
      final settings = TalkerDioLoggerSettings(printRequestData: true);
      final dioRequestLog = DioRequestLog('Test message',
          requestOptions: requestOptions, settings: settings);

      final result = dioRequestLog.generateTextMessage();

      expect(result, contains('Data: {\n  "key": "value"\n}'));
    });

    test(
        'generateTextMessage should include headers if printRequestHeaders is true',
        () {
      final requestOptions = RequestOptions(
          path: '/test',
          method: 'GET',
          headers: {'Authorization': 'Bearer Token'});
      final settings = TalkerDioLoggerSettings(printRequestHeaders: true);
      final dioRequestLog = DioRequestLog('Test message',
          requestOptions: requestOptions, settings: settings);

      final result = dioRequestLog.generateTextMessage();

      expect(
          result, contains('Headers: {\n  "Authorization": "Bearer Token"\n}'));
    });

    test('logLevel should return settings logLevel', () {
      final requestOptions = RequestOptions(path: '/test', method: 'GET');
      final settings = TalkerDioLoggerSettings(
        logLevel: LogLevel.info,
      );
      final dioRequestLog = DioRequestLog(
        'Test message',
        requestOptions: requestOptions,
        settings: settings,
      );

      expect(dioRequestLog.logLevel, equals(LogLevel.info));
    });

    // Add more tests for DioRequestLog as needed
  });

  group('DioResponseLog', () {
    test('generateTextMessage should include method, message, and status', () {
      final response = Response(
        requestOptions: RequestOptions(path: '/test', method: 'GET'),
        statusCode: 200,
        data: {'key': 'value'},
        headers: Headers.fromMap({
          'content-type': ['application/json']
        }),
      );
      final settings = TalkerDioLoggerSettings(
        responsePen: AnsiPen()..blue(),
      );
      final dioResponseLog = DioResponseLog(
        'Test message',
        response: response,
        settings: settings,
      );

      final result = dioResponseLog.generateTextMessage();

      expect(dioResponseLog.pen, isNotNull);
      expect(result, contains('[GET] Test message'));
      expect(result, contains('Status: 200'));
      expect(result, contains('Data: {\n  "key": "value"\n}'));
    });

    test(
        'generateTextMessage should include message if printResponseMessage is true',
        () {
      final response = Response(
        requestOptions: RequestOptions(path: '/test', method: 'GET'),
        statusCode: 200,
        statusMessage: 'OK',
      );
      final settings = TalkerDioLoggerSettings(printResponseMessage: true);
      final dioResponseLog = DioResponseLog(
        'Test message',
        response: response,
        settings: settings,
      );

      final result = dioResponseLog.generateTextMessage();

      expect(result, contains('Message: OK'));
    });

    test(
        'generateTextMessage should include headers if printResponseHeaders is true',
        () {
      final response = Response(
        requestOptions: RequestOptions(path: '/test', method: 'GET'),
        statusCode: 200,
        headers: Headers.fromMap({
          'content-type': ['application/json'],
        }),
      );
      final settings = TalkerDioLoggerSettings(printResponseHeaders: true);
      final dioResponseLog = DioResponseLog('Test message',
          response: response, settings: settings);

      final result = dioResponseLog.generateTextMessage();

      expect(
          result,
          contains('Headers: {\n'
              '  "content-type": [\n'
              '    "application/json"\n'
              '  ]\n'
              '}'));
    });

    test('logLevel should return settings logLevel', () {
      final response = Response(
        requestOptions: RequestOptions(path: '/test', method: 'GET'),
        statusCode: 200,
      );
      final settings = TalkerDioLoggerSettings(
        logLevel: LogLevel.warning,
      );
      final dioResponseLog = DioResponseLog(
        'Test message',
        response: response,
        settings: settings,
      );

      expect(dioResponseLog.logLevel, equals(LogLevel.warning));
    });

    // Add more tests for DioResponseLog as needed
  });

  group('DioErrorLog', () {
    test('generateTextMessage should include method, title, and message', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test', method: 'GET'),
        message: 'Error message',
      );
      final settings = TalkerDioLoggerSettings(
        errorPen: AnsiPen()..blue(),
      );
      final dioErrorLog = DioErrorLog('Error title',
          dioException: dioException, settings: settings);

      final result = dioErrorLog.generateTextMessage();

      expect(
          result,
          contains('[log] [GET] Error title\n'
              'Message: Error message'));
    });

    test(
        'generateTextMessage should not include data, header and message if disabled',
        () {
      final dioException = DioException(
          requestOptions: RequestOptions(path: '/test', method: 'GET'),
          message: 'Error message',
          response: Response(
              requestOptions: RequestOptions(path: '/test', method: 'GET'),
              headers: Headers.fromMap(
                {
                  'content-type': ['application/json'],
                },
              )));
      final settings = TalkerDioLoggerSettings(
        errorPen: AnsiPen()..blue(),
        printErrorData: false,
        printErrorHeaders: false,
        printErrorMessage: false,
      );
      final dioErrorLog = DioErrorLog('Error title',
          dioException: dioException, settings: settings);

      final result = dioErrorLog.generateTextMessage();
      expect(result, contains('[log] [GET] Error title'));
      expect(result, isNot(contains('Message: Error message')));
      expect(
          result,
          isNot(contains(
            'Headers: {\n'
            '  "content-type": [\n'
            '    "application/json"\n'
            '  ]\n'
            '}',
          )));
    });

    test(
        'generateTextMessage should include status if response has a status code',
        () {
      final response = Response(
        requestOptions: RequestOptions(path: '/test', method: 'GET'),
        statusCode: 404,
      );
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test', method: 'GET'),
        response: response,
        message: 'Error message',
      );

      final settings = TalkerDioLoggerSettings();
      final dioErrorLog = DioErrorLog('Error title',
          dioException: dioException, settings: settings);

      final result = dioErrorLog.generateTextMessage();

      expect(result, contains('Status: 404'));
    });

    test('generateTextMessage should include data if response has data', () {
      final response = Response(
        requestOptions: RequestOptions(path: '/test', method: 'GET'),
        statusCode: 500,
        data: {'error': 'Internal Server Error'},
      );

      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test', method: 'GET'),
        message: 'Error message',
        response: response,
      );

      final settings = TalkerDioLoggerSettings();
      final dioErrorLog = DioErrorLog('Error title',
          dioException: dioException, settings: settings);

      final result = dioErrorLog.generateTextMessage();

      expect(
          result, contains('Data: {\n  "error": "Internal Server Error"\n}'));
    });

    test('generateTextMessage should include headers if request has headers',
        () {
      final response = Response(
          requestOptions: RequestOptions(path: '/test', method: 'GET'));
      response.headers = Headers.fromMap(
        {
          'content-type': ['application/json'],
        },
      );
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test', method: 'GET'),
        message: 'Error message',
        response: response,
      );

      final settings = TalkerDioLoggerSettings(printResponseHeaders: true);
      final dioErrorLog = DioErrorLog('Error title',
          dioException: dioException, settings: settings);

      final result = dioErrorLog.generateTextMessage();

      expect(
          result,
          contains(
            'Headers: {\n'
            '  "content-type": [\n'
            '    "application/json"\n'
            '  ]\n'
            '}',
          ));
    });

    test('logLevel should always return error level', () {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test', method: 'GET'),
        message: 'Error message',
      );
      final settings = TalkerDioLoggerSettings(
        logLevel: LogLevel.info,
      );
      final dioErrorLog = DioErrorLog(
        'Error title',
        dioException: dioException,
        settings: settings,
      );

      expect(dioErrorLog.logLevel, equals(LogLevel.error));
    });
  });
}
