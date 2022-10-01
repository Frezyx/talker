import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_dio_logger/http_logs.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'talker_dio_logger_settings.dart';

/// [Dio] http client logger on [Talker] base
///
/// [talker] filed is current [Talker] instance.
/// Provide your instance if your application used [Talker] as default logger
/// Commont Talker instance will be used by default
class TalkerDioLogger extends Interceptor {
  TalkerDioLogger({
    Talker? talker,
    this.settings = const TalkerDioLoggerSettings(),
  }) {
    _talker = talker ??
        Talker(
          loggerOutput: debugPrint,
          settings: TalkerSettings(
            useConsoleLogs: kDebugMode,
            useHistory: kDebugMode,
          ),
          loggerSettings: TalkerLoggerSettings(
            enableColors: !Platform.isIOS && !Platform.isMacOS,
          ),
        );
  }

  late Talker _talker;

  /// [TalkerDioLogger] settings and customization
  final TalkerDioLoggerSettings settings;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    super.onRequest(options, handler);
    var message = '${options.uri}';
    message += '\nMETHOD: ${options.method}';
    final httpLog = HttpRequestLog(
      message,
      data: options.data,
      headers: options.headers,
      printData: settings.printRequestData,
      printHeaders: settings.printRequestHeaders,
    );
    _talker.logTyped(httpLog);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    final message =
        'STATUS: [${response.statusCode}] | ${response.requestOptions.uri}';
    final httpLog = HttpResponseLog(
      message,
      data: response.data,
      headers: response.requestOptions.headers,
      printData: settings.printResponseData,
      printHeaders: settings.printResponseHeaders,
    );
    _talker.logTyped(httpLog);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    _talker.handle(
      err,
      StackTrace.current,
      '''URL: ${err.requestOptions.uri}
METHOD: ${err.requestOptions.method}
STATUS-CODE: ${err.response?.statusCode}''',
    );
  }
}
