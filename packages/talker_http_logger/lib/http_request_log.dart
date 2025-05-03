import 'dart:convert' show JsonEncoder;

import 'package:http_interceptor/http_interceptor.dart';
import 'package:talker/talker.dart';
import 'package:talker_http_logger/talker_http_logger_settings.dart';

class HttpRequestLog extends TalkerLog {
  HttpRequestLog(
    super.title, {
    required this.request,
    required this.settings,
  });

  final BaseRequest request;
  final TalkerHttpLoggerSettings settings;

  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');
  static const String _hiddenValue = '*****';

  @override
  AnsiPen get pen => (AnsiPen()..xterm(219));

  @override
  String get key => TalkerLogType.httpRequest.key;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final StringBuffer msg = StringBuffer();
    msg.write('[$title]');
    msg.write(' [${request.method}]');
    msg.writeln(' $message');

    final Map<String, String> headers = {...request.headers};

    try {
      if (headers.isNotEmpty) {
        if (settings.hiddenHeaders.isNotEmpty) {
          headers.updateAll((String key, String value) {
            return settings.hiddenHeaders
                    .map((v) => v.toLowerCase())
                    .contains(key.toLowerCase())
                ? _hiddenValue
                : value;
          });
        }
        msg.write('Headers: ${_encoder.convert(headers)}');
      }
    } catch (_) {
      // TODO: add handling can`t convert
    }

    return msg.toString().trimRight();
  }
}
