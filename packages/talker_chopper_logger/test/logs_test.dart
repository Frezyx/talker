import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:talker/talker.dart';
import 'package:talker_chopper_logger/chopper_logs.dart';
import 'package:talker_chopper_logger/talker_chopper_logger_interceptor.dart';
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
            body: {'key': 'value'},
          ),
          settings: const TalkerChopperLoggerSettings(printRequestData: true),
        );

        expect(
          log.generateTextMessage(),
          contains('Data: {\n  "key": "value"\n}'),
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
              headers: {
                TalkerChopperLogger.kChopperLogsTimeStampKey:
                    DateTime.timestamp().millisecondsSinceEpoch.toString(),
              },
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
              headers: {
                TalkerChopperLogger.kChopperLogsTimeStampKey:
                    DateTime.timestamp().millisecondsSinceEpoch.toString(),
              },
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
            headers: {
              TalkerChopperLogger.kChopperLogsTimeStampKey:
                  DateTime.timestamp().millisecondsSinceEpoch.toString(),
            },
          ),
          'responseErrorBody',
        ),
        settings: const TalkerChopperLoggerSettings(printResponseTime: true),
      );

      expect(log.generateTextMessage(), matches(RegExp(r'Time: \d+ ms')));
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
  });
}
