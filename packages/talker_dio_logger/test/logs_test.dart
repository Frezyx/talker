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

    test(
        'generateTextMessage should include redirects if printResponseRedirects is true',
        () {
      final requestOptions = RequestOptions(
        path: '/test',
        method: 'GET',
      );
      final settings = TalkerDioLoggerSettings(printResponseRedirects: true);
      final dioRequestLog = DioResponseLog(
        'Test message',
        response: Response(
          requestOptions: requestOptions,
          redirects: [
            RedirectRecord(200, 'GET', Uri.parse('about:blank')),
            RedirectRecord(200, 'POST', Uri.parse('about:blank')),
          ],
        ),
        settings: settings,
      );

      final result = dioRequestLog.generateTextMessage();

      expect(
          result,
          contains(
              'Redirects:\n[200 GET - about:blank]\n[200 POST - about:blank]'));
    });

    test(
        'generateTextMessage should not include redirects if printResponseRedirects is false',
        () {
      final requestOptions = RequestOptions(
        path: '/test',
        method: 'GET',
      );
      final settings = TalkerDioLoggerSettings(printResponseRedirects: false);
      final dioRequestLog = DioResponseLog(
        'Test message',
        response: Response(
          requestOptions: requestOptions,
          redirects: [
            RedirectRecord(200, 'GET', Uri.parse('about:blank')),
          ],
        ),
        settings: settings,
      );

      final result = dioRequestLog.generateTextMessage();
      expect(result.contains('Redirects:'), isFalse);
    });

    test(
        'generateTextMessage should include FormData fields if printRequestData is true',
        () {
      final formData = FormData.fromMap({
        'username': 'testuser',
        'email': 'test@example.com',
        'age': '25',
      });

      final requestOptions = RequestOptions(
        path: '/test',
        method: 'POST',
        data: formData,
      );
      final settings = TalkerDioLoggerSettings(printRequestData: true);
      final dioRequestLog = DioRequestLog(
        'Test message',
        requestOptions: requestOptions,
        settings: settings,
      );

      final result = dioRequestLog.generateTextMessage();

      expect(result, contains('Data:'));
      expect(result, contains('"username": "testuser"'));
      expect(result, contains('"email": "test@example.com"'));
      expect(result, contains('"age": "25"'));
    });

    test(
        'generateTextMessage should include FormData files metadata if printRequestData is true',
        () {
      final formData = FormData();
      formData.fields.add(MapEntry('title', 'Test Document'));
      formData.files.add(MapEntry(
        'document',
        MultipartFile.fromString(
          'test content',
          filename: 'test.txt',
        ),
      ));

      final requestOptions = RequestOptions(
        path: '/test',
        method: 'POST',
        data: formData,
      );
      final settings = TalkerDioLoggerSettings(printRequestData: true);
      final dioRequestLog = DioRequestLog(
        'Test message',
        requestOptions: requestOptions,
        settings: settings,
      );

      final result = dioRequestLog.generateTextMessage();

      expect(result, contains('Data:'));
      expect(result, contains('"title": "Test Document"'));
      expect(result, contains('"document":'));
      expect(result, contains('"filename": "test.txt"'));
      expect(result, contains('"contentType":'));
      expect(result, contains('"bytes":'));
    });

    test(
        'generateTextMessage should include both FormData fields and files if printRequestData is true',
        () {
      final formData = FormData();
      formData.fields.add(MapEntry('username', 'testuser'));
      formData.fields.add(MapEntry('description', 'Test description'));
      formData.files.add(MapEntry(
        'avatar',
        MultipartFile.fromString(
          'image data',
          filename: 'avatar.jpg',
        ),
      ));
      formData.files.add(MapEntry(
        'document',
        MultipartFile.fromString(
          'document data',
          filename: 'document.pdf',
        ),
      ));

      final requestOptions = RequestOptions(
        path: '/upload',
        method: 'POST',
        data: formData,
      );
      final settings = TalkerDioLoggerSettings(printRequestData: true);
      final dioRequestLog = DioRequestLog(
        'Upload request',
        requestOptions: requestOptions,
        settings: settings,
      );

      final result = dioRequestLog.generateTextMessage();

      expect(result, contains('Data:'));
      // Check fields
      expect(result, contains('"username": "testuser"'));
      expect(result, contains('"description": "Test description"'));
      // Check files
      expect(result, contains('"avatar":'));
      expect(result, contains('"filename": "avatar.jpg"'));
      expect(result, contains('"document":'));
      expect(result, contains('"filename": "document.pdf"'));
    });

    test(
        'generateTextMessage should not include FormData if printRequestData is false',
        () {
      final formData = FormData.fromMap({
        'username': 'testuser',
        'email': 'test@example.com',
      });

      final requestOptions = RequestOptions(
        path: '/test',
        method: 'POST',
        data: formData,
      );
      final settings = TalkerDioLoggerSettings(printRequestData: false);
      final dioRequestLog = DioRequestLog(
        'Test message',
        requestOptions: requestOptions,
        settings: settings,
      );

      final result = dioRequestLog.generateTextMessage();

      expect(result, isNot(contains('Data:')));
      expect(result, isNot(contains('"username"')));
      expect(result, isNot(contains('"email"')));
    });

    test(
        'generateTextMessage should include headers with FormData if printRequestHeaders is true',
        () {
      final formData = FormData.fromMap({'field': 'value'});

      final requestOptions = RequestOptions(
        path: '/test',
        method: 'POST',
        data: formData,
        headers: {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer token123',
        },
      );
      final settings = TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: true,
      );
      final dioRequestLog = DioRequestLog(
        'Test message',
        requestOptions: requestOptions,
        settings: settings,
      );

      final result = dioRequestLog.generateTextMessage();

      expect(result, contains('Data:'));
      expect(result, contains('"field": "value"'));
      expect(result, contains('Headers:'));
      expect(result, contains('"Content-Type": "multipart/form-data"'));
      expect(result, contains('"Authorization": "Bearer token123"'));
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
        'generateTextMessage should include response time if printResponseTime is true',
        () {
      final response = Response(
        requestOptions: RequestOptions(path: '/test', method: 'GET', extra: {
          TalkerDioLogger.kDioLogsTimeStampKey:
              DateTime.now().millisecondsSinceEpoch,
        }),
        statusCode: 200,
        statusMessage: 'OK',
      );
      final settings = TalkerDioLoggerSettings(printResponseTime: true);
      final dioResponseLog = DioResponseLog(
        'Test message',
        response: response,
        settings: settings,
      );

      final result = dioResponseLog.generateTextMessage();

      expect(result, matches(RegExp(r'Time: \d+ ms')));
    });

    test(
        'generateTextMessage should not include response time if printResponseTime is false',
        () {
      final response = Response(
        requestOptions: RequestOptions(path: '/test', method: 'GET', extra: {
          TalkerDioLogger.kDioLogsTimeStampKey:
              DateTime.now().millisecondsSinceEpoch,
        }),
        statusCode: 200,
        statusMessage: 'OK',
      );
      final settings = TalkerDioLoggerSettings(printResponseTime: false);
      final dioResponseLog = DioResponseLog(
        'Test message',
        response: response,
        settings: settings,
      );

      final result = dioResponseLog.generateTextMessage();

      expect(result, isNot(contains('Time:')));
    });

    test(
        'generateTextMessage error should include include response time if printResponseTime is true',
        () {
      final response = Response(
        requestOptions: RequestOptions(path: '/test', method: 'GET', extra: {
          TalkerDioLogger.kDioLogsTimeStampKey:
              DateTime.now().millisecondsSinceEpoch,
        }),
        statusCode: 404,
      );
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test', method: 'GET', extra: {
          TalkerDioLogger.kDioLogsTimeStampKey:
              DateTime.now().millisecondsSinceEpoch,
        }),
        response: response,
        message: 'Error message',
      );

      final settings = TalkerDioLoggerSettings(printResponseTime: true);
      final dioErrorLog = DioErrorLog('Error title',
          dioException: dioException, settings: settings);

      final result = dioErrorLog.generateTextMessage();

      expect(result, matches(RegExp(r'Time: \d+ ms')));
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
