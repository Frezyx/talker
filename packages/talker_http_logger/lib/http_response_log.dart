import 'dart:convert' show JsonEncoder, jsonDecode;

import 'package:http_interceptor/http_interceptor.dart';
import 'package:meta/meta.dart';
import 'package:talker/talker.dart';
import 'package:talker_http_logger/response_time.dart';
import 'package:talker_http_logger/talker_http_logger_settings.dart';

class HttpResponseLog extends TalkerLog with ResponseTime {
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
  String get key => TalkerKey.httpResponse;

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
    msg.writeln(' $message');

    final String? data = switch (response) {
      Response res => res.body,
      _ => null,
    };

    msg.writeln('Status: ${response.statusCode}');

    if (settings.printResponseTime) {
      final int? responseTime = getResponseTime(response.headers) ??
          getResponseTime(response.request?.headers);

      if (responseTime != null) {
        msg.writeln('Time: $responseTime ms');
      }
    }

    if (settings.printResponseMessage && response.reasonPhrase != null) {
      msg.writeln('Message: ${response.reasonPhrase}');
    }

    if (settings.printResponseHeaders && response.headers.isNotEmpty) {
      try {
        msg.writeln('Headers: ${convert(response.headers)}');
      } catch (error, stackTrace) {
        msg.writeln(
          'Headers: <failed to convert headers: $error\nstackTrace: $stackTrace>',
        );
      }
    }

    if (settings.printResponseRedirects && response.isRedirect) {
      msg.writeln('Redirect: ${response.isRedirect}');
    }

    if (settings.printResponseData && (data?.isNotEmpty ?? false)) {
      try {
        msg.writeln('Data: ${convert(jsonDecode(data!))}');
      } on FormatException {
        msg.writeln('Data: ${convert(data)}');
      } catch (error, stackTrace) {
        msg.writeln(
          'Data: <failed to convert data: $error\nstackTrace: $stackTrace>',
        );
      }
    }

    return msg.toString().trimRight();
  }
}
