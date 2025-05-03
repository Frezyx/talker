import 'dart:convert' show JsonEncoder;

import 'package:http_interceptor/http_interceptor.dart';
import 'package:meta/meta.dart';
import 'package:talker/talker.dart';
import 'package:talker_http_logger/response_time.dart';
import 'package:talker_http_logger/talker_http_logger_settings.dart';

class HttpErrorLog extends TalkerLog with ResponseTime {
  HttpErrorLog(
    super.title, {
    this.request,
    required this.response,
    required this.settings,
    super.exception,
    super.stackTrace,
  });

  final BaseRequest? request;
  final BaseResponse response;
  final TalkerHttpLoggerSettings settings;

  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  @override
  AnsiPen get pen => settings.errorPen ?? (AnsiPen()..red());

  @override
  String get key => TalkerLogType.httpError.key;

  @override
  LogLevel get logLevel => LogLevel.error;

  @visibleForTesting
  String convert(Object? object) => _encoder.convert(object);

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final StringBuffer msg = StringBuffer();

    msg.write('[$title]');
    msg.writeln(' [${response.request?.method ?? request?.method}]');
    msg.writeln('Status: ${response.statusCode}');

    final String? responseMessage = switch (exception) {
      ClientException ex => ex.message,
      Exception ex => ex.toString(),
      _ => message,
    };

    if (settings.printResponseTime) {
      final int? responseTime = getResponseTime(response.headers);

      if (responseTime != null) {
        msg.writeln('Time: $responseTime ms');
      }
    }

    if (settings.printErrorMessage && (responseMessage?.isNotEmpty ?? false)) {
      msg.writeln('Message: $responseMessage');
    }

    if (settings.printErrorHeaders && response.headers.isNotEmpty) {
      msg.writeln('Headers: ${convert(response.headers)}');
    }

    final String? data = switch (response) {
      Response res => res.body,
      _ => null,
    };

    if (settings.printErrorData && data != null) {
      msg.writeln('Data: $data}');
    }

    return msg.toString().trimRight();
  }
}
