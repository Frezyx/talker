import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:talker/talker.dart';
import 'package:talker_http_logger/http_error_log.dart';
import 'package:talker_http_logger/http_request_log.dart';
import 'package:talker_http_logger/http_response_log.dart';
import 'package:talker_http_logger/talker_http_logger_interceptor.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerHttpLogger tests', () {
    late TalkerHttpLogger logger;
    late Talker talker;
    late Request fakeRequest;

    setUp(() {
      talker = Talker(settings: TalkerSettings(useConsoleLogs: false));
      logger = TalkerHttpLogger(talker: talker);
      fakeRequest = Request(HttpMethod.GET.name, Uri.parse('/test'));
    });

    test('configure method should update logger settings', () {
      logger.configure(printRequestData: true);
      expect(logger.settings.printRequestData, true);
    });

    test('interceptRequest method should log http GET request', () async {
      logger.configure(printRequestHeaders: true);

      await logger.interceptRequest(request: fakeRequest);

      expect(talker.history.firstOrNull?.message, fakeRequest.url.toString());
      expect(talker.history.firstOrNull, isA<HttpRequestLog>());
      expect(
        talker.history.firstOrNull?.generateTextMessage(),
        '[http-request] [GET] /test',
      );
    });

    test('interceptRequest method should log http POST request', () async {
      logger.configure(printRequestHeaders: true);

      final Request postRequest = fakeRequest.copyWith(
        method: HttpMethod.POST,
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode({
          'foo': 'bar',
          'baz': 'qux',
        }),
      );

      await logger.interceptRequest(request: postRequest);

      expect(talker.history.firstOrNull?.message, postRequest.url.toString());
      expect(talker.history.firstOrNull, isA<HttpRequestLog>());
      expect(
        talker.history.firstOrNull?.generateTextMessage(),
        '''[http-request] [POST] /test
Headers: {
  "content-type": "application/json; charset=utf-8"
}
Data: {
  "foo": "bar",
  "baz": "qux"
}''',
      );
    });

    test('interceptRequest method should log http PUT request', () async {
      logger.configure(printRequestHeaders: true);

      final Request putRequest = fakeRequest.copyWith(
        method: HttpMethod.PUT,
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode({
          'foo': 'bar',
          'baz': 'qux',
        }),
      );

      await logger.interceptRequest(request: putRequest);

      expect(talker.history.firstOrNull?.message, putRequest.url.toString());
      expect(talker.history.firstOrNull, isA<HttpRequestLog>());
      expect(
        talker.history.firstOrNull?.generateTextMessage(),
        '''[http-request] [PUT] /test
Headers: {
  "content-type": "application/json; charset=utf-8"
}
Data: {
  "foo": "bar",
  "baz": "qux"
}''',
      );
    });

    test('interceptRequest method should log http PATCH request', () async {
      logger.configure(printRequestHeaders: true);

      final Request putRequest = fakeRequest.copyWith(
        method: HttpMethod.PATCH,
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode({
          'foo': 'bar',
          'baz': 'qux',
        }),
      );

      await logger.interceptRequest(request: putRequest);

      expect(talker.history.firstOrNull?.message, putRequest.url.toString());
      expect(talker.history.firstOrNull, isA<HttpRequestLog>());
      expect(
        talker.history.firstOrNull?.generateTextMessage(),
        '''[http-request] [PATCH] /test
Headers: {
  "content-type": "application/json; charset=utf-8"
}
Data: {
  "foo": "bar",
  "baz": "qux"
}''',
      );
    });

    test('interceptRequest method should log http DELETE request', () async {
      logger.configure(printRequestHeaders: true);

      final Request deleteRequest =
          fakeRequest.copyWith(method: HttpMethod.DELETE);

      await logger.interceptRequest(request: deleteRequest);

      expect(talker.history.firstOrNull?.message, deleteRequest.url.toString());
      expect(talker.history.firstOrNull, isA<HttpRequestLog>());
      expect(
        talker.history.firstOrNull?.generateTextMessage(),
        '''[http-request] [DELETE] /test
Headers: {
  "content-type": "text/plain; charset=utf-8"
}''',
      );
    });

    test('interceptRequest method should log http HEAD request', () async {
      logger.configure(printRequestHeaders: true);

      final Request headRequest = fakeRequest.copyWith(method: HttpMethod.HEAD);

      await logger.interceptRequest(request: headRequest);

      expect(talker.history.firstOrNull?.message, headRequest.url.toString());
      expect(talker.history.firstOrNull, isA<HttpRequestLog>());
      expect(
        talker.history.firstOrNull?.generateTextMessage(),
        '''[http-request] [HEAD] /test
Headers: {
  "content-type": "text/plain; charset=utf-8"
}''',
      );
    });

    test('interceptResponse method should log http response', () async {
      final Response fakeResponse =
          Response('responseBody', 200, request: fakeRequest);

      final String logMessage =
          fakeResponse.request?.url.toString() ?? fakeRequest.url.toString();

      await logger.interceptResponse(response: fakeResponse);

      expect(talker.history.lastOrNull?.message, logMessage);
      expect(talker.history.lastOrNull, isA<HttpResponseLog>());
      expect(
        talker.history.lastOrNull?.generateTextMessage(),
        '''[http-response] [GET] /test
Status: 200
Data: "responseBody"''',
      );
    });

    test('interceptResponse method should log http 4xx response error',
        () async {
      final Response fakeResponse =
          Response('responseErrorBody', 400, request: fakeRequest);

      await logger.interceptResponse(response: fakeResponse);

      expect(talker.history, isNotEmpty);
      expect(talker.history.lastOrNull, isA<HttpErrorLog>());
      expect(
        talker.history.lastOrNull?.generateTextMessage(),
        '''[http-error] [GET] /test
Status: 400
Data: "responseErrorBody"''',
      );
    });

    test('interceptResponse method should log http 5xx response error',
        () async {
      final Response fakeResponse =
          Response('responseErrorBody', 500, request: fakeRequest);

      await logger.interceptResponse(response: fakeResponse);

      expect(talker.history, isNotEmpty);
      expect(talker.history.lastOrNull, isA<HttpErrorLog>());
      expect(
        talker.history.lastOrNull?.generateTextMessage(),
        '''[http-error] [GET] /test
Status: 500
Data: "responseErrorBody"''',
      );
    });

    test('interceptResponse method should log http response headers', () async {
      logger.configure(printResponseHeaders: true);

      final Response fakeResponse = Response(
        '',
        200,
        headers: <String, String>{'HEADER': 'VALUE'},
        request: fakeRequest,
      );

      await logger.interceptResponse(response: fakeResponse);

      expect(
        talker.history.lastOrNull?.generateTextMessage(),
        '''[http-response] [GET] /test
Status: 200
Headers: {
  "HEADER": "VALUE"
}''',
      );
    });

    test(
        'interceptRequest method should hide specific header values in logging',
        () async {
      logger.configure(
        printRequestHeaders: true,
        hiddenHeaders: {'Authorization'},
      );

      await logger.interceptRequest(
        request: fakeRequest.copyWith(
          headers: {
            "firstHeader": "firstHeaderValue",
            "authorization": "bearer super_secret_token",
            "lastHeader": "lastHeaderValue",
          },
        ),
      );

      expect(
        talker.history.firstOrNull?.generateTextMessage(),
        '''[http-request] [GET] /test
Headers: {
  "content-type": "text/plain; charset=utf-8",
  "firstHeader": "firstHeaderValue",
  "authorization": "*****",
  "lastHeader": "lastHeaderValue"
}''',
      );
    });

    test('interceptResponse should show response time when requested',
        () async {
      logger.configure(printResponseTime: true);

      final Response fakeResponse = Response(
        'responseBody',
        200,
        request: fakeRequest.copyWith(
          headers: {
            TalkerHttpLogger.kLogsTimeStamp:
                (DateTime.timestamp().millisecondsSinceEpoch - 69).toString(),
          },
        ),
      );

      await logger.interceptResponse(response: fakeResponse);

      final String? log = talker.history.lastOrNull?.generateTextMessage();
      expect(log, isNotNull);
      expect(log, isA<String>());
      expect(log, contains('[http-response] [GET] /test'));
      expect(log, contains('Status: 200'));
      expect(log, matches(RegExp(r'Time: \d+ ms')));
      expect(log, contains('Data: "responseBody"'));
    });

    test(
      'interceptResponse should show response time in error when requested',
      () async {
        logger.configure(printResponseTime: true);

        final Response fakeResponse =
            Response('responseErrorBody', 400, request: fakeRequest)
                .copyWith(headers: {
          TalkerHttpLogger.kLogsTimeStamp:
              (DateTime.timestamp().millisecondsSinceEpoch - 69).toString(),
        });

        await logger.interceptResponse(response: fakeResponse);

        final String? log = talker.history.lastOrNull?.generateTextMessage();
        expect(log, isNotNull);
        expect(log, isA<String>());
        expect(log, contains('[http-error] [GET] /test'));
        expect(log, contains('Status: 400'));
        expect(log, matches(RegExp(r'Time: \d+ ms')));
        expect(log, contains('Data: "responseErrorBody"'));
      },
    );

    test('interceptRequest should not log if logger is disabled', () async {
      logger.configure(enabled: false);

      await logger.interceptRequest(request: fakeRequest);

      expect(talker.history, isEmpty);
    });

    test(
      'interceptRequest should not log if request and response are filtered',
      () async {
        logger.configure(
          requestFilter: (_) => false,
          responseFilter: (_) => false,
        );

        await logger.interceptRequest(request: fakeRequest);

        expect(talker.history, isEmpty);
      },
    );

    test(
      'interceptResponse should not log if error is filtered',
      () async {
        logger.configure(
          requestFilter: (_) => false,
          errorFilter: (_) => false,
        );

        await logger.interceptResponse(
          response: Response(
            'responseErrorBodyBase',
            400,
            request: fakeRequest,
          ),
        );

        expect(talker.history, isEmpty);
      },
    );
  });
}
