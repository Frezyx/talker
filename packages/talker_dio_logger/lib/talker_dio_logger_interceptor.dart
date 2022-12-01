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
    try {
      var message = '${options.uri}';
      message += '\nMETHOD: ${options.method}';
      final httpLog = HttpRequestLog(
        message,
        data: options.data,
        headers: options.headers,
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
      final message =
          'STATUS: [${response.statusCode}] | ${response.requestOptions.uri}';
      final httpLog = HttpResponseLog(
        message,
        responseMessage: response.statusMessage,
        data: response.data,
        headers: response.requestOptions.headers,
        settings: settings,
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
      _talker.handle(
        err,
        null,
        '''URL: ${err.requestOptions.uri}
  METHOD: ${err.requestOptions.method}
  ${err.response?.statusCode != null ? 'STATUS-CODE: ${err.response?.statusCode}' : ''}''',
      );
    } catch (_) {
      //pass
    }
  }
}
