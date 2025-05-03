import 'dart:convert' show JsonEncoder;

import 'package:http_interceptor/http_interceptor.dart';
import 'package:meta/meta.dart';
import 'package:talker/talker.dart';
import 'package:talker_http_logger/talker_http_logger_settings.dart';

class HttpErrorLog extends TalkerLog {
  HttpErrorLog(
    super.title, {
    required this.response,
    required this.settings,
    super.exception,
    super.stackTrace,
  });

  final BaseResponse response;
  final TalkerHttpLoggerSettings settings;

  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  @override
  AnsiPen get pen => AnsiPen()..red();

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
    msg.write(' [${response.request?.method}]');
    msg.writeln(' $message');

    msg.writeln('Status: ${response.statusCode}');

    try {
      if (response.request?.headers.isNotEmpty ?? false) {
        msg.write('Headers: ${convert(response.request?.headers)}');
      }
    } catch (_) {
      // TODO: add handling can`t convert
    }

    return msg.toString().trimRight();
  }
}
