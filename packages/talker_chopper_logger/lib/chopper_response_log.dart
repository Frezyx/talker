import 'dart:convert' show JsonEncoder;

import 'package:chopper/chopper.dart' show Request, Response;
import 'package:meta/meta.dart' show visibleForTesting;
import 'package:talker/talker.dart';
import 'package:talker_chopper_logger/talker_chopper_logger_settings.dart';

class ChopperResponseLog<BodyType> extends TalkerLog {
  ChopperResponseLog(
    String super.message, {
    this.request,
    required this.response,
    required this.settings,
    this.responseTime = 0,
  });

  final Request? request;
  final Response<BodyType> response;
  final TalkerChopperLoggerSettings settings;
  final int responseTime;

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
    if (response.base.request?.method.isNotEmpty != null ||
        request?.method.isNotEmpty != null) {
      msg.write(' [${response.base.request?.method ?? request?.method}]');
    }
    msg.writeln(' $message');

    final String? responseMessage = response.base.reasonPhrase;
    final BodyType? data = response.body;
    final Map<String, String> headers = response.headers;
    final bool isRedirect = response.base.isRedirect;

    msg.writeln('Status: ${response.statusCode}');

    if (settings.printResponseTime) {
      msg.writeln('Time: $responseTime ms');
    }

    if (settings.printResponseMessage && responseMessage != null) {
      msg.writeln('Message: $responseMessage');
    }

    if (settings.printResponseHeaders && headers.isNotEmpty) {
      try {
        msg.writeln('Headers: ${convert(headers)}');
      } catch (error, stackTrace) {
        msg.writeln(
          'Headers: <failed to convert headers: $error\nstackTrace: $stackTrace>',
        );
      }
    }

    if (settings.printResponseRedirects && isRedirect) {
      msg.writeln('Redirect: $isRedirect');
    }

    if (settings.printResponseData && data != null) {
      try {
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
