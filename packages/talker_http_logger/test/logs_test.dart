import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:talker/talker.dart';
import 'package:talker_http_logger/curl_request.dart';
import 'package:talker_http_logger/http_error_log.dart';
import 'package:talker_http_logger/http_request_log.dart';
import 'package:talker_http_logger/http_response_log.dart';
import 'package:talker_http_logger/talker_http_logger.dart';
import 'package:test/test.dart';

class _MockHttpRequestLog extends HttpRequestLog {
  _MockHttpRequestLog(
    super.title, {
    required super.request,
    required super.settings,
  });

  @override
  String convert(Object? object) => throw Exception('forced error');
}

class _MockHttpResponseLog extends HttpResponseLog {
  _MockHttpResponseLog(
    super.title, {
    required super.response,
    required super.settings,
  });

  @override
  String convert(Object? object) => throw Exception('forced error');
}

void main() {
  late Request request;

  setUp(() {
    request = Request(HttpMethod.GET.name, Uri.parse('/test'));
  });

  group('HttpRequestLog', () {
    test('generateTextMessage should include method and message', () {
      final HttpRequestLog log = HttpRequestLog(
        'Test message',
        request: request,
        settings: TalkerHttpLoggerSettings(
          requestPen: AnsiPen()..blue(),
        ),
      );

      expect(
        log.generateTextMessage(),
        contains('[GET] Test message'),
      );
    });

    test(
      'generateTextMessage should include data if printRequestData is true',
      () {
        final HttpRequestLog log = HttpRequestLog(
          null,
          request: request.copyWith(
            method: HttpMethod.POST,
            body: jsonEncode({
              'foo': 'bar',
              'baz': 'qux',
            }),
          ),
          settings: const TalkerHttpLoggerSettings(printRequestData: true),
        );

        expect(
          log.generateTextMessage(),
          contains(
            '''Data: {
  "foo": "bar",
  "baz": "qux"
}''',
          ),
        );
      },
    );

    test(
      'generateTextMessage with BaseRequest should include form data if printRequestData is true',
      () {
        final HttpRequestLog log = HttpRequestLog(
          null,
          request: request.copyWith(
            method: HttpMethod.POST,
            body: jsonEncode({
              'foo': 'bar',
              'baz': 'qux',
            }),
          ),
          settings: const TalkerHttpLoggerSettings(printRequestData: true),
        );

        expect(
          log.generateTextMessage(),
          contains(
            '''Data: {
  "foo": "bar",
  "baz": "qux"
}''',
          ),
        );
      },
    );

    test(
      'generateTextMessage should include headers if printRequestHeaders is true',
      () {
        final HttpRequestLog log = HttpRequestLog(
          null,
          request: request.copyWith(
            headers: {'Authorization': 'Bearer Token'},
          ),
          settings: const TalkerHttpLoggerSettings(printRequestHeaders: true),
        );

        expect(
          log.generateTextMessage(),
          contains('"Authorization": "Bearer Token"'),
        );
      },
    );

    test(
      'generateTextMessage should include redirect if printResponseRedirects is true',
      () {
        final HttpResponseLog log = HttpResponseLog(
          '',
          response: Response(
            '',
            200,
            request: request,
            isRedirect: true,
          ),
          settings: const TalkerHttpLoggerSettings(
            printResponseRedirects: true,
          ),
        );

        expect(log.generateTextMessage(), contains('Redirect: true'));
      },
    );

    test(
      'generateTextMessage should not include redirects if printResponseRedirects is false',
      () {
        final HttpResponseLog log = HttpResponseLog(
          '',
          response: Response(
            '',
            200,
            request: request,
            isRedirect: true,
          ),
          settings: const TalkerHttpLoggerSettings(
            printResponseRedirects: false,
          ),
        );

        final result = log.generateTextMessage();
        expect(result.contains('Redirect:'), isFalse);
      },
    );

    test(
      'generateTextMessage should include curl command if printRequestCurl is true',
      () {
        final HttpRequestLog log = HttpRequestLog(
          null,
          request: request,
          settings: const TalkerHttpLoggerSettings(printRequestCurl: true),
        );

        final String out = log.generateTextMessage();

        expect(out, contains('[cURL]'));
        expect(out, contains('curl -v'));
        expect(out, contains('-X ${request.method}'));
        expect(out, contains('${request.url}'));
        expect(out, contains('[cURL] ${request.toCurl()}'));
      },
    );

    test(
      'generateTextMessage should include curl command with headers if printRequestCurl is true',
      () {
        final Request requestWithHeaders = request.copyWith(
          headers: {
            'foo': 'bar',
            'baz': 'qux',
          },
        );

        final HttpRequestLog log = HttpRequestLog(
          null,
          request: requestWithHeaders,
          settings: const TalkerHttpLoggerSettings(
            printRequestCurl: true,
            hiddenHeaders: {'baz'},
          ),
        );

        final String out = log.generateTextMessage();

        expect(out, contains('[cURL]'));
        expect(out, contains('curl -v'));
        expect(out, contains('-X ${requestWithHeaders.method}'));
        expect(out, contains("-H 'foo: bar'"));
        expect(out, isNot(contains("-H 'baz: qux'")));
        expect(out, contains("-H 'baz: *****'"));
        expect(out, contains('${requestWithHeaders.url}'));
        expect(
          out,
          contains(
            '[cURL] ${requestWithHeaders.copyWith(headers: {
                  ...requestWithHeaders.headers,
                  'baz': '*****',
                }).toCurl()}',
          ),
        );
      },
    );

    test(
      'generateTextMessage should include curl command with body if printRequestCurl is true',
      () {
        final Request postRequest = request.copyWith(
          method: HttpMethod.POST,
          body: jsonEncode({
            'foo': 'bar',
            'baz': 'qux',
          }),
        );

        final HttpRequestLog log = HttpRequestLog(
          null,
          request: postRequest,
          settings: const TalkerHttpLoggerSettings(printRequestCurl: true),
        );

        final String out = log.generateTextMessage();

        expect(out, contains('[cURL]'));
        expect(out, contains('curl -v'));
        expect(out, contains('-X ${postRequest.method}'));
        expect(out, contains(r"""-d '{"foo":"bar","baz":"qux"}'"""));
        expect(out, contains('${postRequest.url}'));
        expect(out, contains('[cURL] ${postRequest.toCurl()}'));
      },
    );

    test(
      'generateTextMessage with baseRequest should include curl command with form data if printRequestCurl is true',
      () {
        final BaseRequest postRequest = request.copyWith(
          method: HttpMethod.POST,
          headers: {
            'content-type': 'application/json; charset=utf-8',
          },
          body: jsonEncode({
            'foo': 'bar',
            'baz': 'qux',
          }),
        );

        final HttpRequestLog log = HttpRequestLog(
          null,
          request: postRequest,
          settings: const TalkerHttpLoggerSettings(printRequestCurl: true),
        );

        final String out = log.generateTextMessage();

        expect(out, contains('[cURL]'));
        expect(out, contains('curl -v'));
        expect(out, contains('-X ${postRequest.method}'));
        expect(
          out,
          contains(
            "-H 'content-type: application/json; charset=utf-8'",
          ),
        );
        expect(out, contains("""-d '{"foo":"bar","baz":"qux"}'"""));
        expect(out, contains('${postRequest.url}'));
        expect(out, contains('[cURL] ${postRequest.toCurl()}'));
      },
    );

    test('logLevel should return settings logLevel', () {
      final HttpRequestLog log = HttpRequestLog(
        'Test message',
        request: request,
        settings: const TalkerHttpLoggerSettings(logLevel: LogLevel.info),
      );

      expect(log.logLevel, equals(LogLevel.info));
    });

    test('force throw exception on convert headers', () {
      final HttpRequestLog log = _MockHttpRequestLog(
        'Test message',
        request: request.copyWith(headers: {
          'foo': 'bar',
          'baz': 'qux',
        }),
        settings: const TalkerHttpLoggerSettings(printRequestHeaders: true),
      );

      expect(() => log.convert('foo'), throwsA(isA<Exception>()));

      expect(() => log.generateTextMessage(), returnsNormally);

      final String result = log.generateTextMessage();
      expect(result, contains('[GET] Test message'));
      expect(result, contains('Headers: <failed to convert headers:'));
      expect(result, contains('stackTrace:'));
    });

    test('force throw exception on convert Request JSON data', () {
      final HttpRequestLog log = _MockHttpRequestLog(
        'Test message',
        request: request.copyWith(
          method: HttpMethod.POST,
          headers: {
            'content-type': 'application/json',
          },
          body: jsonEncode({
            'foo': 'bar',
            'baz': 'qux',
          }),
        ),
        settings: const TalkerHttpLoggerSettings(printRequestData: true),
      );

      expect(() => log.convert('foo'), throwsA(isA<Exception>()));

      expect(() => log.generateTextMessage(), returnsNormally);

      final String result = log.generateTextMessage();
      expect(result, contains('[POST] Test message'));
      expect(result, contains('Data: <failed to convert data:'));
      expect(result, contains('stackTrace:'));
    });

    test(
      'force throw exception on convert BaseRequest with JSON data',
      () {
        final HttpRequestLog log = _MockHttpRequestLog(
          'Test message',
          request: request.copyWith(
            method: HttpMethod.POST,
            headers: {
              'content-type': 'application/json',
            },
            body: jsonEncode({
              'foo': 'bar',
              'baz': 'qux',
            }),
          ),
          settings: const TalkerHttpLoggerSettings(printRequestData: true),
        );

        expect(() => log.convert('foo'), throwsA(isA<Exception>()));

        expect(() => log.generateTextMessage(), returnsNormally);

        final String result = log.generateTextMessage();
        expect(result, contains('[POST] Test message'));
        expect(result, contains('Data: <failed to convert data:'));
        expect(result, contains('stackTrace:'));
      },
    );

    test('force throw exception on convert Request with data', () {
      final HttpRequestLog log = _MockHttpRequestLog(
        'Test message',
        request: request.copyWith(
          method: HttpMethod.POST,
          body: jsonEncode({
            'foo': 'bar',
            'baz': 'qux',
          }),
        ),
        settings: const TalkerHttpLoggerSettings(printRequestData: true),
      );

      expect(() => log.convert('foo'), throwsA(isA<Exception>()));

      expect(() => log.generateTextMessage(), returnsNormally);

      final String result = log.generateTextMessage();
      expect(result, contains('[POST] Test message'));
      expect(result, contains('Data: <failed to convert data:'));
      expect(result, contains('stackTrace:'));
    });
  });

  group('HttpResponseLog', () {
    test('generateTextMessage should include method, message, and status', () {
      final HttpResponseLog log = HttpResponseLog(
        'Test message',
        response: Response(
          jsonEncode({'key': 'value'}),
          200,
          request: request,
          headers: <String, String>{
            'content-type': 'application/json',
          },
        ),
        settings: TalkerHttpLoggerSettings(
          responsePen: AnsiPen()..blue(),
        ),
      );

      final String result = log.generateTextMessage();

      expect(log.pen, isNotNull);
      expect(result, contains('[GET] Test message'));
      expect(result, contains('Status: 200'));
      expect(result, contains('Data: {\n  "key": "value"\n}'));
    });

    test(
      'generateTextMessage should include message if printResponseMessage is true',
      () {
        final HttpResponseLog log = HttpResponseLog(
          'Test message',
          response: Response(
            'responseBodyBase',
            200,
            request: request,
            reasonPhrase: 'OK',
          ),
          settings: const TalkerHttpLoggerSettings(printResponseMessage: true),
        );

        expect(log.generateTextMessage(), contains('Message: OK'));
      },
    );

    test(
      'generateTextMessage should include response time if printResponseTime is true',
      () {
        final HttpResponseLog log = HttpResponseLog(
          'Test message',
          response: Response(
            'responseBodyBase',
            200,
            request: request,
            reasonPhrase: 'OK',
            headers: {
              TalkerHttpLogger.kLogsTimeStamp:
                  (DateTime.timestamp().millisecondsSinceEpoch - 123)
                      .toString(),
            },
          ),
          settings: const TalkerHttpLoggerSettings(printResponseTime: true),
        );

        expect(log.generateTextMessage(), matches(RegExp(r'Time: \d+ ms')));
      },
    );

    test(
      'generateTextMessage should not include response time if printResponseTime is false',
      () {
        final HttpResponseLog log = HttpResponseLog(
          'Test message',
          response: Response(
            'responseBodyBase',
            200,
            request: request,
            reasonPhrase: 'OK',
            headers: {
              TalkerHttpLogger.kLogsTimeStamp:
                  (DateTime.timestamp().millisecondsSinceEpoch - 123)
                      .toString(),
            },
          ),
          settings: const TalkerHttpLoggerSettings(printResponseTime: false),
        );

        expect(log.generateTextMessage(), isNot(contains('Time:')));
      },
    );

    test(
        'generateTextMessage error should include include response time if printResponseTime is true',
        () {
      final HttpResponseLog log = HttpResponseLog(
        'Error title',
        response: Response(
          'responseErrorBodyBase',
          404,
          request: request,
          reasonPhrase: 'Error message',
          headers: {
            TalkerHttpLogger.kLogsTimeStamp:
                (DateTime.timestamp().millisecondsSinceEpoch - 123).toString(),
          },
        ),
        settings: const TalkerHttpLoggerSettings(printResponseTime: true),
      );

      expect(log.generateTextMessage(), matches(RegExp(r'Time: \d+ ms')));
    });

    test('logLevel should return settings logLevel', () {
      final HttpResponseLog log = HttpResponseLog(
        'Test message',
        response: Response(
          'responseBodyBase',
          200,
          request: request,
          reasonPhrase: 'OK',
        ),
        settings: const TalkerHttpLoggerSettings(logLevel: LogLevel.warning),
      );

      expect(log.logLevel, equals(LogLevel.warning));
    });

    test('force throw exception on convert Response headers', () {
      final HttpResponseLog log = _MockHttpResponseLog(
        'Test message',
        response: Response(
          jsonEncode({
            'foo': 'bar',
            'baz': 'qux',
          }),
          200,
          request: request,
          headers: {
            'content-type': 'application/json',
          },
          reasonPhrase: 'OK',
        ),
        settings: const TalkerHttpLoggerSettings(printResponseHeaders: true),
      );

      expect(() => log.convert('foo'), throwsA(isA<Exception>()));

      expect(() => log.generateTextMessage(), returnsNormally);

      final String result = log.generateTextMessage();
      expect(result, contains('[GET] Test message'));
      expect(result, contains('Headers: <failed to convert headers:'));
      expect(result, contains('stackTrace:'));
    });

    test('force throw exception on convert Response JSON data', () {
      final HttpResponseLog log = _MockHttpResponseLog(
        'Test message',
        response: Response(
          jsonEncode({
            'foo': 'bar',
            'baz': 'qux',
          }),
          200,
          request: request,
          headers: {
            'content-type': 'application/json',
          },
          reasonPhrase: 'OK',
        ),
        settings: const TalkerHttpLoggerSettings(printResponseData: true),
      );

      expect(() => log.convert('foo'), throwsA(isA<Exception>()));

      expect(() => log.generateTextMessage(), returnsNormally);

      final String result = log.generateTextMessage();
      expect(result, contains('[GET] Test message'));
      expect(result, contains('Data: <failed to convert data:'));
      expect(result, contains('stackTrace:'));
    });
  });

  group('HttpErrorLog', () {
    test('generateTextMessage should include method, title, and message', () {
      final HttpErrorLog log = HttpErrorLog(
        'Error title',
        exception: ClientException(
          'Error message',
          request.url,
        ),
        request: request,
        settings: TalkerHttpLoggerSettings(
          errorPen: AnsiPen()..blue(),
        ),
      );

      expect(
        log.generateTextMessage(),
        contains('[log] [GET] /test\nMessage: Error message'),
      );
    });

    test(
      'generateTextMessage should not include data, header and message if disabled',
      () {
        final HttpErrorLog log = HttpErrorLog(
          'Error title',
          exception: ClientException(
            'Error message',
            request.url,
          ),
          response: Response(
            'responseErrorBodyBase',
            404,
            request: request,
            reasonPhrase: 'Error message',
            headers: {
              'content-type': 'application/json',
            },
          ),
          settings: TalkerHttpLoggerSettings(
            errorPen: AnsiPen()..blue(),
            printErrorData: false,
            printErrorHeaders: false,
            printErrorMessage: false,
          ),
        );

        final String result = log.generateTextMessage();

        expect(result, contains('[log] [GET] /test'));
        expect(result, isNot(contains('Message: Error message')));
        expect(
          result,
          isNot(
            contains(
              'Headers: {\n'
              '  "content-type": [\n'
              '    "application/json"\n'
              '  ]\n'
              '}',
            ),
          ),
        );
      },
    );

    test(
      'generateTextMessage should include status if response has a status code',
      () {
        final HttpErrorLog log = HttpErrorLog(
          'Error title',
          exception: ClientException(
            'Error message',
            request.url,
          ),
          response: Response(
            'responseErrorBodyBase',
            404,
            request: request,
            reasonPhrase: 'Error message',
          ),
          settings: const TalkerHttpLoggerSettings(),
        );

        expect(log.generateTextMessage(), contains('Status: 404'));
      },
    );

    test(
      'generateTextMessage should include data if response has data',
      () {
        final HttpErrorLog log = HttpErrorLog(
          'Error title',
          exception: ClientException(
            'Error message',
            request.url,
          ),
          response: Response(
            jsonEncode({'error': 'Internal Server Error'}),
            500,
            request: request,
            reasonPhrase: 'Error message',
          ),
          settings: const TalkerHttpLoggerSettings(),
        );

        expect(
          log.generateTextMessage(),
          contains('Data: {\n  "error": "Internal Server Error"\n}'),
        );
      },
    );

    test(
      'generateTextMessage should include headers if request has headers',
      () {
        final HttpErrorLog log = HttpErrorLog(
          'Error title',
          exception: ClientException(
            'Error message',
            request.url,
          ),
          response: Response(
            jsonEncode({'error': 'Internal Server Error'}),
            500,
            request: request,
            reasonPhrase: 'Error message',
            headers: {
              'content-type': 'application/json',
            },
          ),
          settings: const TalkerHttpLoggerSettings(printResponseHeaders: true),
        );

        expect(
          log.generateTextMessage(),
          contains(
            'Headers: {\n'
            '  "content-type": "application/json"\n'
            '}',
          ),
        );
      },
    );

    test('logLevel should always return error level', () {
      final HttpErrorLog log = HttpErrorLog(
        'Error title',
        exception: ClientException(
          'Error message',
          request.url,
        ),
        response: Response(
          'responseErrorBodyBase',
          404,
          request: request,
          reasonPhrase: 'Error message',
        ),
        settings: const TalkerHttpLoggerSettings(logLevel: LogLevel.info),
      );

      expect(log.logLevel, equals(LogLevel.error));
    });
  });
}
