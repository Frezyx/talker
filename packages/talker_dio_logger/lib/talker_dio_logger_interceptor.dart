import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/http_logs.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

/// [Dio] http client logger on [Talker] base
///
/// [talker] filed is current [Talker] instance.
/// Provide your instance if your application used [Talker] as default logger
/// Commont Talker instance will be used by default
class TalkerDioLogger extends Interceptor {
  TalkerDioLogger({
    Talker? talker,
    this.settings = const TalkerDioLoggerSettings(),
    this.addonId,
  }) {
    _talker = talker ?? Talker();
    _talker.registerAddon(
      code: addonId ?? TalkerOriginalAddons.talkerDioLogger.code,
      addon: this,
    );
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
    try {
      final message = '${options.uri}';
      final httpLog = HttpRequestLog(
        message,
        requestOptions: options,
        settings: settings,
      );
      _talker.logTyped(httpLog);
    } catch (_) {
      //pass
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    try {
      final message = '${response.requestOptions.uri}';
      final httpLog = HttpResponseLog(
        message,
        settings: settings,
        response: response,
      );
      _talker.logTyped(httpLog);
    } catch (_) {
      //pass
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    try {
      final message = '${err.requestOptions.uri}';
      final httpErrorLog = HttpErrorLog(
        message,
        dioError: err,
        settings: settings,
      );
      _talker.logTyped(httpErrorLog);
    } catch (_) {
      //pass
    }
  }
}
