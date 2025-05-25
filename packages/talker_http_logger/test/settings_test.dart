import 'package:http_interceptor/http_interceptor.dart';
import 'package:talker/talker.dart';
import 'package:talker_http_logger/talker_http_logger.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerHttpLoggerSettings', () {
    late BaseRequest fakeRequest;

    setUp(() {
      fakeRequest = Request(HttpMethod.GET.name, Uri.parse('/test'));
    });

    test('copyWith should create a new instance with the provided values', () {
      final TalkerHttpLoggerSettings originalSettings =
          const TalkerHttpLoggerSettings();
      final TalkerHttpLoggerSettings updatedSettings =
          originalSettings.copyWith(
        printResponseData: false,
        printRequestHeaders: true,
        printErrorHeaders: false,
        requestPen: AnsiPen()..yellow(),
        responseFilter: null,
      );

      expect(
        originalSettings.printResponseData,
        isNot(same(updatedSettings.printResponseData)),
      );
      expect(updatedSettings.printResponseData, isFalse);
      expect(
        originalSettings.printRequestHeaders,
        isNot(same(updatedSettings.printRequestHeaders)),
      );
      expect(updatedSettings.printRequestHeaders, isTrue);
      expect(
        originalSettings.printErrorHeaders,
        isNot(same(updatedSettings.printErrorHeaders)),
      );
      expect(updatedSettings.printErrorHeaders, isFalse);
      expect(
        updatedSettings.requestPen,
        isNot(same(originalSettings.requestPen)),
      );
      expect(updatedSettings.responseFilter, isNull);

      expect(originalSettings, equals(originalSettings.copyWith()));
    });

    test('requestFilter should return true for allowed paths', () {
      final TalkerHttpLoggerSettings settings = TalkerHttpLoggerSettings(
        requestFilter: (BaseRequest request) => request.url.path == '/allowed',
      );

      final Request allowedRequestOptions = Request(
        HttpMethod.GET.name,
        Uri.parse('/allowed'),
      );

      final Request disallowedRequestOptions = Request(
        HttpMethod.GET.name,
        Uri.parse('/disallowed'),
      );

      expect(settings.requestFilter?.call(allowedRequestOptions), isTrue);
      expect(settings.requestFilter?.call(disallowedRequestOptions), isFalse);
    });

    test('responseFilter should return true for successful responses', () {
      final TalkerHttpLoggerSettings settings = TalkerHttpLoggerSettings(
          responseFilter: (BaseResponse response) =>
              response.statusCode == 200);

      final Response successfulResponse =
          Response('responseBodyBase', 200, request: fakeRequest);

      final Response unsuccessfulResponse =
          Response('responseErrorBodyBase', 404, request: fakeRequest);

      expect(settings.responseFilter?.call(successfulResponse), isTrue);
      expect(settings.responseFilter?.call(unsuccessfulResponse), isFalse);
    });

    test(
      'copyWith should create a new instance with updated values for all fields',
      () {
        final TalkerHttpLoggerSettings originalSettings =
            TalkerHttpLoggerSettings(
          printResponseData: true,
          printResponseHeaders: false,
          printResponseMessage: true,
          printRequestData: true,
          printRequestHeaders: false,
          printErrorHeaders: false,
          printErrorData: true,
          requestPen: AnsiPen()..green(),
          responsePen: AnsiPen()..cyan(),
          errorPen: AnsiPen()..red(),
        );

        final TalkerHttpLoggerSettings updatedSettings =
            originalSettings.copyWith(
          printResponseData: false,
          printRequestHeaders: true,
          printErrorHeaders: true,
          printErrorData: false,
          requestPen: AnsiPen()..yellow(),
        );

        expect(updatedSettings.printResponseData, isFalse);
        expect(updatedSettings.printResponseHeaders, isFalse);
        expect(updatedSettings.printResponseMessage, isTrue);
        expect(updatedSettings.printRequestData, isTrue);
        expect(updatedSettings.printErrorHeaders, isTrue);
        expect(updatedSettings.printErrorData, isFalse);
        expect(updatedSettings.printRequestHeaders, isTrue);
        expect(
          updatedSettings.requestPen,
          isNot(same(originalSettings.requestPen)),
        );
        expect(
          updatedSettings.responsePen,
          equals(originalSettings.responsePen),
        );
        expect(
          updatedSettings.errorPen,
          equals(originalSettings.errorPen),
        );
      },
    );

    test('default logLevel should be debug', () {
      final TalkerHttpLoggerSettings settings =
          const TalkerHttpLoggerSettings();
      expect(settings.logLevel, equals(LogLevel.debug));
    });

    test('copyWith should preserve logLevel if not specified', () {
      final TalkerHttpLoggerSettings originalSettings =
          const TalkerHttpLoggerSettings(logLevel: LogLevel.warning);
      final TalkerHttpLoggerSettings updatedSettings =
          originalSettings.copyWith(printResponseData: false);

      expect(updatedSettings.logLevel, equals(LogLevel.warning));
    });

    test('copyWith should update logLevel when specified', () {
      final TalkerHttpLoggerSettings originalSettings =
          const TalkerHttpLoggerSettings(logLevel: LogLevel.debug);
      final TalkerHttpLoggerSettings updatedSettings =
          originalSettings.copyWith(logLevel: LogLevel.error);

      expect(updatedSettings.logLevel, equals(LogLevel.error));
    });
  });
}
