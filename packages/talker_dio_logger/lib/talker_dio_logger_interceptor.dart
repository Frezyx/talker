import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/dio_logs.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

/// [Dio] http client logger on [Talker] base
///
/// [talker] filed is current [Talker] instance.
/// Provide your instance if your application used [Talker] as default logger
/// Common Talker instance will be used by default
class TalkerDioLogger extends Interceptor {
  TalkerDioLogger({
    Talker? talker,
    this.settings = const TalkerDioLoggerSettings(),
    this.addonId,
  }) {
    _talker = talker ?? Talker();
  }

  late Talker _talker;

  /// [TalkerDioLogger] settings and customization
  TalkerDioLoggerSettings settings;

  /// Talker addon functionality
  /// addon id for create a lot of addons
  final String? addonId;

  /// Method to update [settings] of [TalkerDioLogger]
  void configure({
    bool? printResponseData,
    bool? printResponseHeaders,
    bool? printResponseMessage,
    bool? printErrorData,
    bool? printErrorHeaders,
    bool? printErrorMessage,
    bool? printRequestData,
    bool? printRequestHeaders,
    AnsiPen? requestPen,
    AnsiPen? responsePen,
    AnsiPen? errorPen,
  }) {
    settings = settings.copyWith(
      printRequestData: printRequestData,
      printRequestHeaders: printRequestHeaders,
      printResponseData: printResponseData,
      printErrorData: printErrorData,
      printErrorHeaders: printErrorHeaders,
      printErrorMessage: printErrorMessage,
      printResponseHeaders: printResponseHeaders,
      printResponseMessage: printResponseMessage,
      requestPen: requestPen,
      responsePen: responsePen,
      errorPen: errorPen,
    );
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    super.onRequest(options, handler);
    if (!settings.enabled) {
      return;
    }
    final accepted = settings.requestFilter?.call(options) ?? true;
    if (!accepted) {
      return;
    }
    try {
      final message = '${options.uri}';
      final httpLog = DioRequestLog(
        message,
        requestOptions: options,
        settings: settings,
      );
      _talker.logCustom(httpLog);
    } catch (_) {
      //pass
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    if (!settings.enabled) {
      return;
    }
    final accepted = settings.responseFilter?.call(response) ?? true;
    if (!accepted) {
      return;
    }
    try {
      final message = '${response.requestOptions.uri}';
      final httpLog = DioResponseLog(
        message,
        settings: settings,
        response: response,
      );
      _talker.logCustom(httpLog);
    } catch (_) {
      //pass
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    if (!settings.enabled) {
      return;
    }
    final accepted = settings.errorFilter?.call(err) ?? true;
    if (!accepted) {
      return;
    }
    try {
      final message = '${err.requestOptions.uri}';
      final httpErrorLog = DioErrorLog(
        message,
        dioException: err,
        settings: settings,
      );
      _talker.logCustom(httpErrorLog);
    } catch (_) {
      //pass
    }
  }
}
