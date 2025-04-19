import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:talker/talker.dart';
import 'package:talker_chopper_logger/chopper_logs.dart';
import 'package:talker_chopper_logger/curl_request.dart';
import 'package:talker_chopper_logger/talker_chopper_logger_settings.dart';
import 'package:test/test.dart';

void main() {
  late Request request;

  setUp(() {
    request = Request(HttpMethod.Get, Uri.parse('/test'), Uri.parse('/'));
  });

  group('ChopperRequestLog', () {
    test('generateTextMessage should include method and message', () {
      final ChopperRequestLog log = ChopperRequestLog(
        'Test message',
        request: request,
        settings: TalkerChopperLoggerSettings(
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
        final ChopperRequestLog log = ChopperRequestLog(
          null,
          request: request.copyWith(
            method: HttpMethod.Post,
            body: {
              'foo': 'bar',
              'baz': 'qux',
            },
          ),
          settings: const TalkerChopperLoggerSettings(printRequestData: true),
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
      'generateTextMessage with http.BaseRequest should include form data if printRequestData is true',
      () async {
        final ChopperRequestLog log = ChopperRequestLog(
          null,
          request: await request.copyWith(
            method: HttpMethod.Post,
            body: {
              'foo': 'bar',
              'baz': 'qux',
            },
          ).toBaseRequest(),
          settings: const TalkerChopperLoggerSettings(printRequestData: true),
        );

        expect(
          log.generateTextMessage(),
          contains('Data: foo=bar&baz=qux'),
        );
      },
    );

    test(
      'generateTextMessage with multipart http.baseRequest should include form data if printRequestData is true',
      () async {
        const List<PartValue<Map<String, String>>> parts = [
          PartValue('1', {'foo': 'bar'}),
          PartValue('2', {'baz': 'qux'}),
        ];

        final http.BaseRequest multiPartRequest = await request
            .copyWith(
              method: HttpMethod.Post,
              parts: parts,
              multipart: true,
            )
            .toBaseRequest();

        final ChopperRequestLog log = ChopperRequestLog(
          null,
          request: multiPartRequest,
          settings: const TalkerChopperLoggerSettings(printRequestData: true),
        );

        expect(
          log.generateTextMessage(),
          contains(
            '''Data: {
  "1": "{foo: bar}",
  "2": "{baz: qux}"
}''',
          ),
        );
      },
    );

    test(
      'generateTextMessage with multipart file http.baseRequest should include form data if printRequestData is true',
      () async {
        final file = http.MultipartFile.fromBytes(
          'foo_bar',
          [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
          filename: 'baz_qux',
          contentType: MediaType.parse('application/octet-stream'),
        );

        final List<PartValue<http.MultipartFile>> parts = [
          PartValueFile<http.MultipartFile>(
            'file',
            file,
          ),
        ];

        final http.BaseRequest multiPartRequest = await request
            .copyWith(
              method: HttpMethod.Post,
              parts: parts,
              multipart: true,
            )
            .toBaseRequest();

        final ChopperRequestLog log = ChopperRequestLog(
          null,
          request: multiPartRequest,
          settings: const TalkerChopperLoggerSettings(printRequestData: true),
        );

        expect(
          log.generateTextMessage(),
          contains('Data: {\n  "foo_bar": "baz_qux"\n}'),
        );
      },
    );

    test(
      'generateTextMessage should include headers if printRequestHeaders is true',
      () {
        final ChopperRequestLog log = ChopperRequestLog(
          null,
          request: request.copyWith(
            headers: {'Authorization': 'Bearer Token'},
          ),
          settings:
              const TalkerChopperLoggerSettings(printRequestHeaders: true),
        );

        expect(
          log.generateTextMessage(),
          contains('Headers: {\n  "Authorization": "Bearer Token"\n}'),
        );
      },
    );

    test(
      'generateTextMessage should include redirect if printResponseRedirects is true',
      () async {
        final ChopperResponseLog<String> log = ChopperResponseLog(
          '',
          response: Response<String>(
            http.Response(
              '',
              200,
              request: await request.toBaseRequest(),
              isRedirect: true,
            ),
            null,
          ),
          settings: const TalkerChopperLoggerSettings(
            printResponseRedirects: true,
          ),
        );

        expect(log.generateTextMessage(), contains('Redirect: true'));
      },
    );

    test(
      'generateTextMessage should not include redirects if printResponseRedirects is false',
      () async {
        final ChopperResponseLog<String> log = ChopperResponseLog(
          '',
          response: Response<String>(
            http.Response(
              '',
              200,
              request: await request.toBaseRequest(),
              isRedirect: true,
            ),
            null,
          ),
          settings: const TalkerChopperLoggerSettings(
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
        final ChopperRequestLog log = ChopperRequestLog(
          null,
          request: request,
          settings: const TalkerChopperLoggerSettings(printRequestCurl: true),
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

        final ChopperRequestLog log = ChopperRequestLog(
          null,
          request: requestWithHeaders,
          settings: const TalkerChopperLoggerSettings(
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
          method: HttpMethod.Post,
          body: {
            'foo': 'bar',
            'baz': 'qux',
          },
        );

        final ChopperRequestLog log = ChopperRequestLog(
          null,
          request: postRequest,
          settings: const TalkerChopperLoggerSettings(printRequestCurl: true),
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
      'generateTextMessage with http.baseRequest should include curl command with form data if printRequestCurl is true',
      () async {
        final http.BaseRequest postRequest = await request.copyWith(
          method: HttpMethod.Post,
          body: {
            'foo': 'bar',
            'baz': 'qux',
          },
        ).toBaseRequest();

        final ChopperRequestLog log = ChopperRequestLog(
          null,
          request: postRequest,
          settings: const TalkerChopperLoggerSettings(printRequestCurl: true),
        );

        final String out = log.generateTextMessage();

        expect(out, contains('[cURL]'));
        expect(out, contains('curl -v'));
        expect(out, contains('-X ${postRequest.method}'));
        expect(
          out,
          contains(
            "-H 'content-type: application/x-www-form-urlencoded; charset=utf-8'",
          ),
        );
        expect(out, contains("-d 'foo=bar&baz=qux'"));
        expect(out, contains('${postRequest.url}'));
        expect(out, contains('[cURL] ${postRequest.toCurl()}'));
      },
    );

    test(
      'generateTextMessage with multipart http.baseRequest should include curl command with form data if printRequestCurl is true',
      () async {
        const List<PartValue<Map<String, String>>> parts = [
          PartValue('1', {'foo': 'bar'}),
          PartValue('2', {'baz': 'qux'}),
        ];

        final http.BaseRequest multiPartRequest = await request
            .copyWith(
              method: HttpMethod.Post,
              parts: parts,
              multipart: true,
            )
            .toBaseRequest();

        final ChopperRequestLog log = ChopperRequestLog(
          null,
          request: multiPartRequest,
          settings: const TalkerChopperLoggerSettings(printRequestCurl: true),
        );

        final String out = log.generateTextMessage();

        expect(out, contains('[cURL]'));
        expect(out, contains('curl -v'));
        expect(out, contains('-X ${multiPartRequest.method}'));
        for (final PartValue<Map<String, String>> part in parts) {
          expect(out, contains("-F '${part.name}=${part.value}'"));
        }
        expect(out, contains('${multiPartRequest.url}'));
        expect(out, contains('[cURL] ${multiPartRequest.toCurl()}'));
      },
    );

    test(
      'generateTextMessage with multipart file http.baseRequest should include curl command with form data if printRequestCurl is true',
      () async {
        final file = http.MultipartFile.fromBytes(
          'foo_bar',
          [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
          filename: 'baz_qux',
          contentType: MediaType.parse('application/octet-stream'),
        );

        final List<PartValue<http.MultipartFile>> parts = [
          PartValueFile<http.MultipartFile>(
            'file',
            file,
          ),
        ];

        final http.BaseRequest multiPartRequest = await request
            .copyWith(
              method: HttpMethod.Post,
              parts: parts,
              multipart: true,
            )
            .toBaseRequest();

        final ChopperRequestLog log = ChopperRequestLog(
          null,
          request: multiPartRequest,
          settings: const TalkerChopperLoggerSettings(printRequestCurl: true),
        );

        final String out = log.generateTextMessage();

        expect(out, contains('[cURL]'));
        expect(out, contains('curl -v'));
        expect(out, contains('-X ${multiPartRequest.method}'));
        for (final PartValue<http.MultipartFile> part in parts) {
          expect(
            out,
            contains("-F '${part.value.field}=@${part.value.filename}'"),
          );
        }
        expect(out, contains('${multiPartRequest.url}'));
        expect(out, contains('[cURL] ${multiPartRequest.toCurl()}'));
      },
    );

    test('logLevel should return settings logLevel', () {
      final ChopperRequestLog log = ChopperRequestLog(
        'Test message',
        request: request,
        settings: const TalkerChopperLoggerSettings(logLevel: LogLevel.info),
      );

      expect(log.logLevel, equals(LogLevel.info));
    });
  });

  group('ChopperResponseLog', () {
    test('generateTextMessage should include method, message, and status',
        () async {
      final ChopperResponseLog<Map<String, dynamic>> log = ChopperResponseLog(
        'Test message',
        response: Response<Map<String, dynamic>>(
          http.Response(
            jsonEncode({'key': 'value'}),
            200,
            request: await request.toBaseRequest(),
            headers: <String, String>{
              'content-type': 'application/json',
            },
          ),
          {'key': 'value'},
        ),
        settings: TalkerChopperLoggerSettings(
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
      () async {
        final ChopperResponseLog<String> log = ChopperResponseLog(
          'Test message',
          response: Response<String>(
            http.Response(
              'responseBodyBase',
              200,
              request: await request.toBaseRequest(),
              reasonPhrase: 'OK',
            ),
            'responseBody',
          ),
          settings:
              const TalkerChopperLoggerSettings(printResponseMessage: true),
        );

        expect(log.generateTextMessage(), contains('Message: OK'));
      },
    );

    test(
      'generateTextMessage should include response time if printResponseTime is true',
      () async {
        final ChopperResponseLog<String> log = ChopperResponseLog(
          'Test message',
          response: Response<String>(
            http.Response(
              'responseBodyBase',
              200,
              request: await request.toBaseRequest(),
              reasonPhrase: 'OK',
            ),
            'responseBody',
          ),
          settings: const TalkerChopperLoggerSettings(printResponseTime: true),
        );

        expect(log.generateTextMessage(), matches(RegExp(r'Time: \d+ ms')));
      },
    );

    test(
      'generateTextMessage should not include response time if printResponseTime is false',
      () async {
        final ChopperResponseLog<String> log = ChopperResponseLog(
          'Test message',
          response: Response<String>(
            http.Response(
              'responseBodyBase',
              200,
              request: await request.toBaseRequest(),
              reasonPhrase: 'OK',
            ),
            'responseBody',
          ),
          settings: const TalkerChopperLoggerSettings(printResponseTime: false),
        );

        expect(log.generateTextMessage(), isNot(contains('Time:')));
      },
    );

    test(
        'generateTextMessage error should include include response time if printResponseTime is true',
        () async {
      final ChopperResponseLog<String> log = ChopperResponseLog(
        'Error title',
        response: Response<String>(
          http.Response(
            'responseErrorBodyBase',
            404,
            request: await request.toBaseRequest(),
            reasonPhrase: 'Error message',
          ),
          'responseErrorBody',
        ),
        settings: const TalkerChopperLoggerSettings(printResponseTime: true),
      );

      expect(log.generateTextMessage(), matches(RegExp(r'Time: \d+ ms')));
    });

    test('logLevel should return settings logLevel', () async {
      final ChopperResponseLog<String> log = ChopperResponseLog(
        'Test message',
        response: Response<String>(
          http.Response(
            'responseBodyBase',
            200,
            request: await request.toBaseRequest(),
            reasonPhrase: 'OK',
          ),
          'responseBody',
        ),
        settings: const TalkerChopperLoggerSettings(logLevel: LogLevel.warning),
      );

      expect(log.logLevel, equals(LogLevel.warning));
    });
  });

  group('ChopperErrorLog', () {
    test('generateTextMessage should include method, title, and message', () {
      final ChopperErrorLog log = ChopperErrorLog(
        'Error title',
        chopperException: ChopperException(
          'Error message',
          request: request,
        ),
        settings: TalkerChopperLoggerSettings(
          errorPen: AnsiPen()..blue(),
        ),
      );

      expect(
        log.generateTextMessage(),
        contains(
          '[log] [GET] Error title\n'
          'Message: Error message',
        ),
      );
    });

    test(
      'generateTextMessage should not include data, header and message if disabled',
      () async {
        final ChopperErrorLog log = ChopperErrorLog(
          'Error title',
          chopperException: ChopperException(
            'Error message',
            request: request,
            response: Response<String>(
              http.Response(
                'responseErrorBodyBase',
                404,
                request: await request.toBaseRequest(),
                reasonPhrase: 'Error message',
                headers: {
                  'content-type': 'application/json',
                },
              ),
              'responseErrorBody',
            ),
          ),
          settings: TalkerChopperLoggerSettings(
            errorPen: AnsiPen()..blue(),
            printErrorData: false,
            printErrorHeaders: false,
            printErrorMessage: false,
          ),
        );

        final String result = log.generateTextMessage();

        expect(result, contains('[log] [GET] Error title'));
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
      () async {
        final ChopperErrorLog log = ChopperErrorLog(
          'Error title',
          chopperException: ChopperException(
            'Error message',
            request: request,
            response: Response<String>(
              http.Response(
                'responseErrorBodyBase',
                404,
                request: await request.toBaseRequest(),
                reasonPhrase: 'Error message',
              ),
              'responseErrorBody',
            ),
          ),
          settings: const TalkerChopperLoggerSettings(),
        );

        expect(log.generateTextMessage(), contains('Status: 404'));
      },
    );

    test(
      'generateTextMessage should include data if response has data',
      () async {
        final ChopperErrorLog log = ChopperErrorLog(
          'Error title',
          chopperException: ChopperException(
            'Error message',
            request: request,
            response: Response<Map<String, dynamic>>(
              http.Response(
                jsonEncode({'error': 'Internal Server Error'}),
                500,
                request: await request.toBaseRequest(),
                reasonPhrase: 'Error message',
              ),
              {'error': 'Internal Server Error'},
            ),
          ),
          settings: const TalkerChopperLoggerSettings(),
        );

        expect(
          log.generateTextMessage(),
          contains('Data: {\n  "error": "Internal Server Error"\n}'),
        );
      },
    );

    test(
      'generateTextMessage should include headers if request has headers',
      () async {
        final ChopperErrorLog log = ChopperErrorLog(
          'Error title',
          chopperException: ChopperException(
            'Error message',
            request: request,
            response: Response<Map<String, dynamic>>(
              http.Response(
                jsonEncode({'error': 'Internal Server Error'}),
                500,
                request: await request.toBaseRequest(),
                reasonPhrase: 'Error message',
                headers: {
                  'content-type': 'application/json',
                },
              ),
              {'error': 'Internal Server Error'},
            ),
          ),
          settings:
              const TalkerChopperLoggerSettings(printResponseHeaders: true),
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

    test('logLevel should always return error level', () async {
      final ChopperErrorLog log = ChopperErrorLog(
        'Error title',
        chopperException: ChopperException(
          'Error message',
          request: request,
          response: Response<String>(
            http.Response(
              'responseErrorBodyBase',
              404,
              request: await request.toBaseRequest(),
              reasonPhrase: 'Error message',
            ),
            'responseErrorBody',
          ),
        ),
        settings: const TalkerChopperLoggerSettings(logLevel: LogLevel.info),
      );

      expect(log.logLevel, equals(LogLevel.error));
    });
  });
}
