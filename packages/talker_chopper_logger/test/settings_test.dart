import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:talker/talker.dart';
import 'package:talker_chopper_logger/talker_chopper_logger_settings.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerChopperLoggerSettings', () {
    late Request fakeRequest;

    setUp(() {
      fakeRequest = Request('GET', Uri.parse('/test'), Uri.parse('/'));
    });

    test('copyWith should create a new instance with the provided values', () {
      final TalkerChopperLoggerSettings originalSettings =
          const TalkerChopperLoggerSettings();
      final TalkerChopperLoggerSettings updatedSettings =
          originalSettings.copyWith(
        printResponseData: false,
        printRequestHeaders: true,
        printErrorHeaders: false,
        requestPen: AnsiPen()..yellow(),
        responseFilter: null,
      );

      expect(updatedSettings.printResponseData, isFalse);
      expect(updatedSettings.printRequestHeaders, isTrue);
      expect(updatedSettings.printErrorHeaders, isFalse);
      expect(
        updatedSettings.requestPen,
        isNot(same(originalSettings.requestPen)),
      );
      expect(updatedSettings.responseFilter, isNull);
    });

    test('requestFilter should return true for allowed paths', () {
      final TalkerChopperLoggerSettings settings = TalkerChopperLoggerSettings(
        requestFilter: (Request request) => request.url.path == '/allowed',
      );

      final Request allowedRequestOptions = Request(
        'GET',
        Uri.parse('/allowed'),
        Uri.parse('/'),
      );

      final Request disallowedRequestOptions = Request(
        'GET',
        Uri.parse('/disallowed'),
        Uri.parse('/'),
      );

      expect(settings.requestFilter?.call(allowedRequestOptions), isTrue);
      expect(settings.requestFilter?.call(disallowedRequestOptions), isFalse);
    });

    test(
      'responseFilter should return true for successful responses',
      () async {
        final TalkerChopperLoggerSettings settings =
            TalkerChopperLoggerSettings(
                responseFilter: (Response response) =>
                    response.statusCode == 200);

        final Response<String> successfulResponse = Response<String>(
          http.Response(
            'responseBodyBase',
            200,
            request: await fakeRequest.toBaseRequest(),
          ),
          'responseBody',
        );

        final Response<String> unsuccessfulResponse = Response<String>(
          http.Response(
            'responseErrorBodyBase',
            404,
            request: await fakeRequest.toBaseRequest(),
          ),
          'responseErrorBody',
        );

        expect(settings.responseFilter?.call(successfulResponse), isTrue);
        expect(settings.responseFilter?.call(unsuccessfulResponse), isFalse);
      },
    );

    test(
      'copyWith should create a new instance with updated values for all fields',
      () {
        final TalkerChopperLoggerSettings originalSettings =
            TalkerChopperLoggerSettings(
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

        final TalkerChopperLoggerSettings updatedSettings =
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
  });
}
