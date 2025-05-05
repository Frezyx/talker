import 'package:http_interceptor/http_interceptor.dart';
import 'package:talker/talker.dart';
import 'package:talker_http_logger/http_error_log.dart';
import 'package:talker_http_logger/http_request_log.dart';
import 'package:talker_http_logger/http_response_log.dart';
import 'package:talker_http_logger/talker_http_logger_settings.dart';

class TalkerHttpLogger extends InterceptorContract {
  TalkerHttpLogger({
    Talker? talker,
    this.settings = const TalkerHttpLoggerSettings(),
    this.addonId,
  }) {
    _talker = talker ?? Talker();
  }

  static const String kLogsTimeStamp = 'x-talker-http-logger-ts';

  late final Talker _talker;

  /// [TalkerHttpLogger] settings and customization
  TalkerHttpLoggerSettings settings;

  /// Talker addon functionality addon id for creating a lot of addons
  final String? addonId;

  /// Method to update [settings] of [TalkerHttpLogger]
  void configure({
    bool? enabled,
    LogLevel? logLevel,
    bool? printResponseData,
    bool? printResponseHeaders,
    bool? printResponseMessage,
    bool? printResponseTime,
    bool? printErrorData,
    bool? printErrorHeaders,
    bool? printErrorMessage,
    bool? printRequestData,
    bool? printRequestHeaders,
    bool? printRequestCurl,
    AnsiPen? requestPen,
    AnsiPen? responsePen,
    AnsiPen? errorPen,
    RequestFilter? requestFilter,
    ResponseFilter? responseFilter,
    ResponseFilter? errorFilter,
    Set<String>? hiddenHeaders,
  }) =>
      settings = settings.copyWith(
        enabled: enabled,
        logLevel: logLevel,
        printRequestData: printRequestData,
        printRequestHeaders: printRequestHeaders,
        printRequestCurl: printRequestCurl,
        printResponseData: printResponseData,
        printErrorData: printErrorData,
        printErrorHeaders: printErrorHeaders,
        printErrorMessage: printErrorMessage,
        printResponseHeaders: printResponseHeaders,
        printResponseMessage: printResponseMessage,
        requestPen: requestPen,
        responsePen: responsePen,
        errorPen: errorPen,
        requestFilter: requestFilter,
        responseFilter: responseFilter,
        errorFilter: errorFilter,
        hiddenHeaders: hiddenHeaders,
        printResponseTime: printResponseTime,
      );

  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    if (settings.enabled && (settings.requestFilter?.call(request) ?? true)) {
      if (settings.printResponseTime) {
        request.headers[kLogsTimeStamp] =
            DateTime.timestamp().millisecondsSinceEpoch.toString();
      }

      _talker.logCustom(
        HttpRequestLog(
          request.url.toString(),
          request: request,
          settings: settings,
        ),
      );
    }

    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    final String message = '${response.request?.url}';

    try {
      switch (response.statusCode) {
        case int statusCode when settings.enabled && statusCode < 400:
          if (settings.responseFilter?.call(response) ?? true) {
            _talker.logCustom(
              HttpResponseLog(
                message,
                response: response,
                settings: settings,
              ),
            );
          }
          break;
        case _ when settings.enabled:
          if (settings.errorFilter?.call(response) ?? true) {
            _talker.logCustom(
              HttpErrorLog(
                message,
                request: response.request,
                response: response,
                settings: settings,
              ),
            );
          }
          break;
      }

      return response;
    } catch (exception, stackTrace) {
      switch (exception) {
        case ClientException ex when settings.enabled:
          _talker.error(ex.uri.toString(), ex, stackTrace);
          break;
        case _ when settings.enabled:
          _talker.error(exception.toString(), exception, stackTrace);
          break;
      }

      rethrow;
    }
  }
}
