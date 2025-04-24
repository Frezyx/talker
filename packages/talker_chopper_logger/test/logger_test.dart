import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:talker/talker.dart';
import 'package:talker_chopper_logger/chopper_error_log.dart';
import 'package:talker_chopper_logger/chopper_request_log.dart';
import 'package:talker_chopper_logger/chopper_response_log.dart';
import 'package:talker_chopper_logger/talker_chopper_logger_interceptor.dart';
import 'package:test/test.dart';

import 'helpers/fake_chain.dart';

void main() {
  group('TalkerChopperLogger tests', () {
    late TalkerChopperLogger logger;
    late Talker talker;
    late Request fakeRequest;

    setUp(() {
      talker = Talker(settings: TalkerSettings(useConsoleLogs: false));
      logger = TalkerChopperLogger(talker: talker);
      fakeRequest = Request(HttpMethod.Get, Uri.parse('/test'), Uri.parse('/'));
    });

    test('configure method should update logger settings', () {
      logger.configure(printRequestData: true);
      expect(logger.settings.printRequestData, true);
    });

    test('intercept method should log http GET request', () async {
      logger.configure(printRequestHeaders: true);

      await logger.intercept<String>(FakeChain<String>(fakeRequest));

      expect(talker.history.firstOrNull?.message, fakeRequest.url.toString());
      expect(talker.history.firstOrNull, isA<ChopperRequestLog>());
      expect(
        talker.history.firstOrNull?.generateTextMessage(),
        '[http-request] [GET] /test',
      );
    });

    test('intercept method should log http POST request', () async {
      logger.configure(printRequestHeaders: true);

      final Request postRequest = fakeRequest.copyWith(
        method: HttpMethod.Post,
        body: {
          'foo': 'bar',
          'baz': 'qux',
        },
      );

      await logger.intercept<String>(FakeChain<String>(postRequest));

      expect(talker.history.firstOrNull?.message, postRequest.url.toString());
      expect(talker.history.firstOrNull, isA<ChopperRequestLog>());
      expect(
        talker.history.firstOrNull?.generateTextMessage(),
        '''[http-request] [POST] /test
Headers: {
  "content-type": "application/x-www-form-urlencoded; charset=utf-8"
}
Data: foo=bar&baz=qux''',
      );
    });

    test('intercept method should log http PUT request', () async {
      logger.configure(printRequestHeaders: true);

      final Request putRequest = fakeRequest.copyWith(
        method: HttpMethod.Put,
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode({
          'foo': 'bar',
          'baz': 'qux',
        }),
      );

      await logger.intercept<String>(FakeChain<String>(putRequest));

      expect(talker.history.firstOrNull?.message, putRequest.url.toString());
      expect(talker.history.firstOrNull, isA<ChopperRequestLog>());
      expect(
        talker.history.firstOrNull?.generateTextMessage(),
        '''[http-request] [PUT] /test
Headers: {
  "Content-Type": "application/json; charset=utf-8"
}
Data: {
  "foo": "bar",
  "baz": "qux"
}''',
      );
    });

    test('intercept method should log http PATCH request', () async {
      logger.configure(printRequestHeaders: true);

      final Request putRequest = fakeRequest.copyWith(
        method: HttpMethod.Patch,
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: jsonEncode({
          'foo': 'bar',
          'baz': 'qux',
        }),
      );

      await logger.intercept<String>(FakeChain<String>(putRequest));

      expect(talker.history.firstOrNull?.message, putRequest.url.toString());
      expect(talker.history.firstOrNull, isA<ChopperRequestLog>());
      expect(
        talker.history.firstOrNull?.generateTextMessage(),
        '''[http-request] [PATCH] /test
Headers: {
  "Content-Type": "application/json; charset=utf-8"
}
Data: {
  "foo": "bar",
  "baz": "qux"
}''',
      );
    });

    test('intercept method should log http DELETE request', () async {
      logger.configure(printRequestHeaders: true);

      final Request deleteRequest =
          fakeRequest.copyWith(method: HttpMethod.Delete);

      await logger.intercept<String>(FakeChain<String>(deleteRequest));

      expect(talker.history.firstOrNull?.message, deleteRequest.url.toString());
      expect(talker.history.firstOrNull, isA<ChopperRequestLog>());
      expect(
        talker.history.firstOrNull?.generateTextMessage(),
        '[http-request] [DELETE] /test',
      );
    });

    test('intercept method should log http OPTIONS request', () async {
      logger.configure(printRequestHeaders: true);

      final Request deleteRequest =
          fakeRequest.copyWith(method: HttpMethod.Options);

      await logger.intercept<String>(FakeChain<String>(deleteRequest));

      expect(talker.history.firstOrNull?.message, deleteRequest.url.toString());
      expect(talker.history.firstOrNull, isA<ChopperRequestLog>());
      expect(
        talker.history.firstOrNull?.generateTextMessage(),
        '[http-request] [OPTIONS] /test',
      );
    });

    test('intercept method should log http HEAD request', () async {
      logger.configure(printRequestHeaders: true);

      final Request headRequest = fakeRequest.copyWith(method: HttpMethod.Head);

      await logger.intercept<String>(FakeChain<String>(headRequest));

      expect(talker.history.firstOrNull?.message, headRequest.url.toString());
      expect(talker.history.firstOrNull, isA<ChopperRequestLog>());
      expect(
        talker.history.firstOrNull?.generateTextMessage(),
        '[http-request] [HEAD] /test',
      );
    });

    test('intercept method should log http response', () async {
      final Response<String> fakeResponse = Response<String>(
        http.Response(
          'responseBodyBase',
          200,
          request: await fakeRequest.toBaseRequest(),
        ),
        'responseBody',
      );

      final String logMessage = fakeResponse.base.request?.url.toString() ??
          fakeRequest.url.toString();

      await logger.intercept<String>(
        FakeChain<String>(fakeRequest, response: fakeResponse),
      );

      expect(talker.history.lastOrNull?.message, logMessage);
      expect(talker.history.lastOrNull, isA<ChopperResponseLog<String>>());
      expect(
        talker.history.lastOrNull?.generateTextMessage(),
        '''[http-response] [GET] /test
Status: 200
Data: "responseBody"''',
      );
    });

    test('intercept method should log http response without BaseRequest',
        () async {
      final Response<String> fakeResponse = Response<String>(
        http.Response(
          'responseBodyBase',
          200,
        ),
        'responseBody',
      );

      final String logMessage = fakeResponse.base.request?.url.toString() ??
          fakeRequest.url.toString();

      await logger.intercept<String>(
        FakeChain<String>(fakeRequest, response: fakeResponse),
      );

      expect(talker.history.lastOrNull?.message, logMessage);
      expect(talker.history.lastOrNull, isA<ChopperResponseLog<String>>());
      expect(
        talker.history.lastOrNull?.generateTextMessage(),
        '''[http-response] [GET] /test
Status: 200
Data: "responseBody"''',
      );
    });

    test('intercept method should log http 4xx response error', () async {
      final Response<String> fakeResponse = Response<String>(
        http.Response(
          'responseErrorBodyBase',
          400,
          request: await fakeRequest.toBaseRequest(),
        ),
        'responseErrorBody',
      );

      await logger.intercept<String>(
        FakeChain<String>(fakeRequest, response: fakeResponse),
      );

      expect(talker.history, isNotEmpty);
      expect(talker.history.lastOrNull, isA<ChopperErrorLog<String>>());
      expect(
        talker.history.lastOrNull?.generateTextMessage(),
        '''[http-error] [GET] /test
Status: 400
Data: "responseErrorBody"''',
      );
    });

    test('intercept method should log http 5xx response error', () async {
      final Response<String> fakeResponse = Response<String>(
        http.Response(
          'responseErrorBodyBase',
          500,
          request: await fakeRequest.toBaseRequest(),
        ),
        'responseErrorBody',
      );

      await logger.intercept<String>(
        FakeChain<String>(fakeRequest, response: fakeResponse),
      );

      expect(talker.history, isNotEmpty);
      expect(talker.history.lastOrNull, isA<ChopperErrorLog<String>>());
      expect(
        talker.history.lastOrNull?.generateTextMessage(),
        '''[http-error] [GET] /test
Status: 500
Data: "responseErrorBody"''',
      );
    });

    test('intercept method should log http response headers', () async {
      logger.configure(printResponseHeaders: true);

      final Response<String> fakeResponse = Response<String>(
        http.Response(
          '',
          200,
          headers: <String, String>{'HEADER': 'VALUE'},
          request: await fakeRequest.toBaseRequest(),
        ),
        null,
      );

      await logger.intercept(FakeChain(fakeRequest, response: fakeResponse));

      expect(
        talker.history.lastOrNull?.generateTextMessage(),
        '''[http-response] [GET] /test
Status: 200
Headers: {
  "HEADER": "VALUE"
}''',
      );
    });

    test('intercept method should hide specific header values in logging',
        () async {
      logger.configure(
        printRequestHeaders: true,
        hiddenHeaders: {'Authorization'},
      );

      await logger.intercept(
        FakeChain(
          fakeRequest.copyWith(
            headers: {
              "firstHeader": "firstHeaderValue",
              "authorization": "bearer super_secret_token",
              "lastHeader": "lastHeaderValue",
            },
          ),
        ),
      );

      expect(
        talker.history.firstOrNull?.generateTextMessage(),
        '''[http-request] [GET] /test
Headers: {
  "firstHeader": "firstHeaderValue",
  "authorization": "*****",
  "lastHeader": "lastHeaderValue"
}''',
      );
    });

    test('intercept should show response time when requested', () async {
      logger.configure(printResponseTime: true);

      final Response<String> fakeResponse = Response<String>(
        http.Response(
          'responseBodyBase',
          200,
          request: await fakeRequest.toBaseRequest(),
        ),
        'responseBody',
      );

      await logger.intercept(FakeChain(fakeRequest, response: fakeResponse));

      expect(
        talker.history.lastOrNull?.generateTextMessage(),
        '''[http-response] [GET] /test
Status: 200
Time: 0 ms
Data: "responseBody"''',
      );
    });

    test(
      'intercept should show response time in error when requested',
      () async {
        logger.configure(printResponseTime: true);

        final Response<String> fakeResponse = Response<String>(
          http.Response(
            'responseErrorBodyBase',
            400,
            request: await fakeRequest.toBaseRequest(),
          ),
          'responseErrorBody',
        );

        await logger.intercept(FakeChain(fakeRequest, response: fakeResponse));

        expect(
          talker.history.lastOrNull?.generateTextMessage(),
          '''[http-error] [GET] /test
Status: 400
Time: 0 ms
Data: "responseErrorBody"''',
        );
      },
    );

    test('intercept should not log if logger is disabled', () async {
      logger.configure(enabled: false);

      await logger.intercept(FakeChain(fakeRequest));

      expect(talker.history, isEmpty);
    });

    test(
      'intercept should not log if request and response are filtered',
      () async {
        logger.configure(
          requestFilter: (_) => false,
          responseFilter: (_) => false,
        );

        await logger.intercept(FakeChain(fakeRequest));

        expect(talker.history, isEmpty);
      },
    );

    test(
      'intercept should not log if error is filtered',
      () async {
        logger.configure(
          requestFilter: (_) => false,
          errorFilter: (_) => false,
        );

        await logger.intercept(
          FakeChain(
            fakeRequest,
            response: Response<String>(
              http.Response(
                'responseErrorBodyBase',
                400,
                request: await fakeRequest.toBaseRequest(),
              ),
              'responseErrorBody',
            ),
          ),
        );

        expect(talker.history, isEmpty);
      },
    );

    test('intercept should log ChopperException', () async {
      final ChopperException exception = ChopperException(
        'foo error',
        request: fakeRequest,
        response: Response<String>(
          http.Response(
            'responseErrorBodyBase',
            400,
            request: await fakeRequest.copyWith(
              headers: {
                'foo': 'bar',
                'baz': 'qux',
              },
            ).toBaseRequest(),
            headers: {
              'lorem': 'ipsum',
              'ping': 'pong',
            },
          ),
          'responseErrorBody',
        ),
      );

      try {
        await logger.intercept<String>(
          FakeChain<String>(fakeRequest, exception: exception),
        );
      } catch (err) {
        expect(
          err,
          isA<ChopperException>().having(
            (ChopperException error) => error.message,
            'message',
            contains('foo error'),
          ),
        );
      } finally {
        expect(talker.history, isNotEmpty);
        expect(talker.history.lastOrNull, isA<ChopperErrorLog<String>>());
        expect(
          talker.history.lastOrNull?.generateTextMessage(),
          '''[http-error] [GET] /test
Status: 400
Message: foo error
Headers: {
  "lorem": "ipsum",
  "ping": "pong"
}
Data: "responseErrorBody"''',
        );
      }
    });

    test('intercept should log ChopperException without BaseRequest', () async {
      final ChopperException exception = ChopperException(
        'foo error',
        request: fakeRequest,
        response: Response<String>(
          http.Response(
            'responseErrorBodyBase',
            400,
            headers: {
              'lorem': 'ipsum',
              'ping': 'pong',
            },
          ),
          'responseErrorBody',
        ),
      );

      try {
        await logger.intercept<String>(
          FakeChain<String>(fakeRequest, exception: exception),
        );
      } catch (err) {
        expect(
          err,
          isA<ChopperException>().having(
            (ChopperException error) => error.message,
            'message',
            contains('foo error'),
          ),
        );
      } finally {
        expect(talker.history, isNotEmpty);
        expect(talker.history.lastOrNull, isA<ChopperErrorLog<String>>());
        expect(
          talker.history.lastOrNull?.generateTextMessage(),
          '''[http-error] [GET] /test
Status: 400
Message: foo error
Headers: {
  "lorem": "ipsum",
  "ping": "pong"
}
Data: "responseErrorBody"''',
        );
      }
    });

    test(
        'intercept should log ChopperException without BaseRequest and without Request',
        () async {
      final ChopperException exception = ChopperException(
        'foo error',
        response: Response<String>(
          http.Response(
            'responseErrorBodyBase',
            400,
            headers: {
              'lorem': 'ipsum',
              'ping': 'pong',
            },
          ),
          'responseErrorBody',
        ),
      );

      try {
        await logger.intercept<String>(
          FakeChain<String>(fakeRequest, exception: exception),
        );
      } catch (err) {
        expect(
          err,
          isA<ChopperException>().having(
            (ChopperException error) => error.message,
            'message',
            contains('foo error'),
          ),
        );
      } finally {
        expect(talker.history, isNotEmpty);
        expect(talker.history.lastOrNull, isA<ChopperErrorLog<String>>());
        expect(
          talker.history.lastOrNull?.generateTextMessage(),
          '''[http-error]
Status: 400
Message: foo error
Headers: {
  "lorem": "ipsum",
  "ping": "pong"
}
Data: "responseErrorBody"''',
        );
      }
    });

    test(
      'intercept should show response time in ChopperException when requested',
      () async {
        logger.configure(printResponseTime: true);

        final ChopperException exception = ChopperException(
          'foo error',
          request: fakeRequest,
          response: Response<String>(
            http.Response(
              'responseErrorBodyBase',
              400,
              request: await fakeRequest.copyWith(
                headers: {
                  'foo': 'bar',
                  'baz': 'qux',
                },
              ).toBaseRequest(),
              headers: {
                'lorem': 'ipsum',
                'ping': 'pong',
              },
            ),
            'responseErrorBody',
          ),
        );

        try {
          await logger.intercept<String>(
            FakeChain<String>(fakeRequest, exception: exception),
          );
        } catch (err) {
          expect(
            err,
            isA<ChopperException>().having(
              (ChopperException error) => error.message,
              'message',
              contains('foo error'),
            ),
          );
        } finally {
          expect(talker.history, isNotEmpty);
          expect(talker.history.lastOrNull, isA<ChopperErrorLog<String>>());
          expect(
            talker.history.lastOrNull?.generateTextMessage(),
            '''[http-error] [GET] /test
Status: 400
Time: 0 ms
Message: foo error
Headers: {
  "lorem": "ipsum",
  "ping": "pong"
}
Data: "responseErrorBody"''',
          );
        }
      },
    );

    test('intercept should log ChopperHttpException', () async {
      final exception = ChopperHttpException(
        Response<String>(
          http.Response(
            'responseErrorBodyBase',
            400,
            request: await fakeRequest.copyWith(
              headers: {
                'foo': 'bar',
                'baz': 'qux',
              },
            ).toBaseRequest(),
            headers: {
              'lorem': 'ipsum',
              'ping': 'pong',
            },
          ),
          'responseErrorBody',
        ),
      );

      try {
        await logger.intercept<String>(
          FakeChain<String>(fakeRequest, exception: exception),
        );
      } catch (err) {
        expect(err, isA<ChopperHttpException>());
      } finally {
        expect(talker.history, isNotEmpty);
        expect(talker.history.lastOrNull, isA<ChopperErrorLog<String>>());
        expect(
          talker.history.lastOrNull?.generateTextMessage(),
          '''[http-error] [GET] /test
Status: 400
Headers: {
  "lorem": "ipsum",
  "ping": "pong"
}
Data: "responseErrorBody"''',
        );
      }
    });

    test('intercept should log ChopperHttpException without BaseRequest',
        () async {
      final ChopperHttpException exception = ChopperHttpException(
        Response<String>(
          http.Response(
            'responseErrorBodyBase',
            400,
            headers: {
              'lorem': 'ipsum',
              'ping': 'pong',
            },
          ),
          'responseErrorBody',
        ),
      );

      try {
        await logger.intercept<String>(
          FakeChain<String>(fakeRequest, exception: exception),
        );
      } catch (err) {
        expect(err, isA<ChopperHttpException>());
      } finally {
        expect(talker.history, isNotEmpty);
        expect(talker.history.lastOrNull, isA<ChopperErrorLog<String>>());
        expect(
          talker.history.lastOrNull?.generateTextMessage(),
          '''[http-error]
Status: 400
Headers: {
  "lorem": "ipsum",
  "ping": "pong"
}
Data: "responseErrorBody"''',
        );
      }
    });

    test(
      'intercept should show response time in ChopperHttpException when requested',
      () async {
        logger.configure(printResponseTime: true);

        final ChopperHttpException exception = ChopperHttpException(
          Response<String>(
            http.Response(
              'responseErrorBodyBase',
              400,
              request: await fakeRequest.copyWith(
                headers: {
                  'foo': 'bar',
                  'baz': 'qux',
                },
              ).toBaseRequest(),
              headers: {
                'lorem': 'ipsum',
                'ping': 'pong',
              },
            ),
            'responseErrorBody',
          ),
        );

        try {
          await logger.intercept<String>(
            FakeChain<String>(fakeRequest, exception: exception),
          );
        } catch (err) {
          expect(err, isA<ChopperHttpException>());
        } finally {
          expect(talker.history, isNotEmpty);
          expect(talker.history.lastOrNull, isA<ChopperErrorLog<String>>());
          expect(
            talker.history.lastOrNull?.generateTextMessage(),
            '''[http-error] [GET] /test
Status: 400
Time: 0 ms
Headers: {
  "lorem": "ipsum",
  "ping": "pong"
}
Data: "responseErrorBody"''',
          );
        }
      },
    );

    test('intercept should log generic Exception', () async {
      final Exception exception = Exception('foo error');

      try {
        await logger.intercept<String>(
          FakeChain<String>(fakeRequest, exception: exception),
        );
      } catch (err) {
        expect(
          err,
          isA<Exception>().having(
            (Exception error) => error.toString(),
            'message',
            contains('foo error'),
          ),
        );
      } finally {
        expect(talker.history, isNotEmpty);
        expect(talker.history.lastOrNull, isA<TalkerLog>());

        final String out = talker.history.last.generateTextMessage();
        expect(
          RegExp(
            r'^\[error\] \| \d{1,2}:\d{1,2}:\d{1,2} \d+ms \| Exception: foo error',
          ).hasMatch(out),
          isTrue,
        );
        expect(out, contains('StackTrace:'));
      }
    });

    test('intercept should log Timeout Exception', () async {
      final TimeoutException exception = TimeoutException("too late");

      try {
        await logger.intercept<String>(
          FakeChain<String>(fakeRequest, exception: exception),
        );
      } catch (err) {
        expect(
          err,
          isA<TimeoutException>().having(
            (TimeoutException error) => error.message,
            'message',
            contains('too late'),
          ),
        );
      } finally {
        expect(talker.history, isNotEmpty);
        expect(talker.history.lastOrNull, isA<TalkerLog>());
        final String out = talker.history.last.generateTextMessage();
        expect(
          RegExp(
            r'^\[error\] \| \d{1,2}:\d{1,2}:\d{1,2} \d+ms \| TimeoutException: too late',
          ).hasMatch(talker.history.last.generateTextMessage()),
          isTrue,
        );
        expect(out, contains('StackTrace:'));
      }
    });
  });
}
