import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:talker_dio_logger/http_logs.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'talker_dio_logger_settings.dart';

class TalkerDioLogger extends Interceptor {
  TalkerDioLogger({
    Talker? talker,
    this.settings = const TalkerDioLoggerSettings(),
  }) {
    _talker = talker ?? Talker(loggerOutput: debugPrint);
  }

  late Talker _talker;
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
