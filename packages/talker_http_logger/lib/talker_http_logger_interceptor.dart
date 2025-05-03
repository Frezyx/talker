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
  }) {
    _talker = talker ?? Talker();
  }

  late final Talker _talker;

  /// [TalkerHttpLogger] settings and customization
  TalkerHttpLoggerSettings settings;

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
    final message = '${request.url}';
    _talker.logCustom(
      HttpRequestLog(
        message,
        request: request,
        settings: settings,
      ),
    );
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    final String message = '${response.request?.url}';

    if (response.statusCode < 400) {
      _talker.logCustom(
        HttpResponseLog(
          message,
          response: response,
          settings: settings,
        ),
      );
    } else {
      _talker.logCustom(
        HttpErrorLog(
          message,
          response: response,
          settings: settings,
        ),
      );
    }

    return response;
  }
}
