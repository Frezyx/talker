import 'dart:convert' show JsonEncoder;

import 'package:http_interceptor/http_interceptor.dart';
import 'package:meta/meta.dart';
import 'package:talker/talker.dart';
import 'package:talker_http_logger/talker_http_logger_settings.dart';

class HttpResponseLog extends TalkerLog {
  HttpResponseLog(
    super.title, {
    required this.response,
    required this.settings,
  });

  final BaseResponse response;
  final TalkerHttpLoggerSettings settings;

  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  @override
  AnsiPen get pen => settings.responsePen ?? (AnsiPen()..xterm(46));

  @override
  String get key => TalkerLogType.httpResponse.key;

  @override
  LogLevel get logLevel => settings.logLevel;

  @visibleForTesting
  String convert(Object? object) => _encoder.convert(object);

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final StringBuffer msg = StringBuffer();
    msg.write('[$title]');
    msg.write(' [${response.request?.method}]');
    msg.write(' $message');

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
