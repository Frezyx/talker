import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:talker/talker.dart';
import 'package:talker_chopper_logger/chopper_logs.dart';
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

    test('intercept method should log http request', () async {
      final String logMessage = fakeRequest.url.toString();

      await logger.intercept<String>(FakeChain<String>(fakeRequest));

      expect(talker.history.firstOrNull?.message, logMessage);
      expect(talker.history.firstOrNull, isA<ChopperRequestLog>());
      expect(
        talker.history.firstOrNull?.generateTextMessage(),
        '[http-request] [GET] /test',
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
        FakeChain<String>(fakeRequest, fakeResponse),
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

    test('intercept method should log http response error', () async {
      final Response<String> fakeResponse = Response<String>(
        http.Response(
          'responseErrorBodyBase',
          400,
          request: await fakeRequest.toBaseRequest(),
        ),
        'responseErrorBody',
      );

      await logger.intercept<String>(
        FakeChain<String>(fakeRequest, fakeResponse),
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

      await logger.intercept(FakeChain(fakeRequest, fakeResponse));

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
  });
}
