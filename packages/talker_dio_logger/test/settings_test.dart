import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerDioLoggerSettings', () {
    test('copyWith should create a new instance with the provided values', () {
      final originalSettings = TalkerDioLoggerSettings();
      final updatedSettings = originalSettings.copyWith(
        printResponseData: false,
        printRequestHeaders: true,
        printErrorHeaders: false,
        requestPen: AnsiPen()..yellow(),
        responseFilter: null,
        responseDataConverter: null,
      );

      expect(updatedSettings.printResponseData, equals(false));
      expect(updatedSettings.printRequestHeaders, equals(true));
      expect(updatedSettings.printErrorHeaders, equals(false));
      expect(
          updatedSettings.requestPen, isNot(same(originalSettings.requestPen)));
      expect(updatedSettings.responseFilter, isNull);
      expect(updatedSettings.responseDataConverter, isNull);
    });

    test('requestFilter should return true for allowed paths', () {
      final settings = TalkerDioLoggerSettings(
          requestFilter: (RequestOptions requestOptions) =>
              requestOptions.path == '/allowed');
      final allowedRequestOptions =
          RequestOptions(path: '/allowed', method: 'GET');
      final disallowedRequestOptions =
          RequestOptions(path: '/disallowed', method: 'GET');

      expect(settings.requestFilter!(allowedRequestOptions), equals(true));
      expect(settings.requestFilter!(disallowedRequestOptions), equals(false));
    });

    test('responseFilter should return true for successful responses', () {
      final settings = TalkerDioLoggerSettings(
          responseFilter: (Response response) => response.statusCode == 200);
      final successfulResponse = Response(
          requestOptions: RequestOptions(path: '/test'), statusCode: 200);
      final unsuccessfulResponse = Response(
          requestOptions: RequestOptions(path: '/test'), statusCode: 404);

      expect(settings.responseFilter!(successfulResponse), equals(true));
      expect(settings.responseFilter!(unsuccessfulResponse), equals(false));
    });

    test('responseDataConverter should return true for successful responses', () {
      final settings = TalkerDioLoggerSettings(
          responseDataConverter: (Response response) => "msg");
      final successfulResponse = Response(data: "msg");
      expect(settings.responseDataConverter!(successfulResponse), equals("msg"));
    });

    test('errorFilter should return true for cancelled responses', () {
      final settings = TalkerDioLoggerSettings(
          errorFilter: (DioException err) =>
              err.type == DioExceptionType.cancel);
      final cancelledResponse = DioException(
          requestOptions: RequestOptions(path: '/test'),
          type: DioExceptionType.cancel);
      final timeoutResponse = DioException(
          requestOptions: RequestOptions(path: '/test'),
          type: DioExceptionType.sendTimeout);

      expect(settings.errorFilter!(cancelledResponse), equals(true));
      expect(settings.errorFilter!(timeoutResponse), equals(false));
    });

    test(
        'copyWith should create a new instance with updated values for all fields',
        () {
      final originalSettings = TalkerDioLoggerSettings(
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

      final updatedSettings = originalSettings.copyWith(
        printResponseData: false,
        printRequestHeaders: true,
        printErrorHeaders: true,
        printErrorData: false,
        requestPen: AnsiPen()..yellow(),
      );

      expect(updatedSettings.printResponseData, equals(false));
      expect(updatedSettings.printResponseHeaders, equals(false));
      expect(updatedSettings.printResponseMessage, equals(true));
      expect(updatedSettings.printRequestData, equals(true));
      expect(updatedSettings.printErrorHeaders, equals(true));
      expect(updatedSettings.printErrorData, equals(false));
      expect(
        updatedSettings.printRequestHeaders,
        equals(true),
      );
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
    });

    test('default logLevel should be debug', () {
      final settings = TalkerDioLoggerSettings();
      expect(settings.logLevel, equals(LogLevel.debug));
    });

    test('copyWith should preserve logLevel if not specified', () {
      final originalSettings = TalkerDioLoggerSettings(
        logLevel: LogLevel.warning,
      );
      final updatedSettings = originalSettings.copyWith(
        printResponseData: false,
      );

      expect(updatedSettings.logLevel, equals(LogLevel.warning));
    });

    test('copyWith should update logLevel when specified', () {
      final originalSettings = TalkerDioLoggerSettings(
        logLevel: LogLevel.debug,
      );
      final updatedSettings = originalSettings.copyWith(
        logLevel: LogLevel.error,
      );

      expect(updatedSettings.logLevel, equals(LogLevel.error));
    });
  });
}
