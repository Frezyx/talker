import 'dart:convert';

import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

const encoder = JsonEncoder.withIndent('  ');

class HttpRequestLog extends TalkerLog {
  HttpRequestLog(
    String title, {
    required this.headers,
    required this.settings,
    this.data,
  }) : super(title);

  final dynamic data;
  final Map<String, dynamic> headers;
  final TalkerDioLoggerSettings settings;

  @override
  AnsiPen get pen => settings.requestPen ?? AnsiPen()
    ..xterm(219);

  @override
  String get title => 'HTTP';

  @override
  String generateTextMessage() {
    var msg = '[$displayTitle] $message';

    if (settings.printRequestData && data != null) {
      final prettyData = encoder.convert(data);
      msg += '\nDATA:$prettyData';
    }
    if (settings.printRequestHeaders && headers.isNotEmpty) {
      final prettyHeaders = encoder.convert(headers);
      msg += '\nHEADERS:$prettyHeaders';
    }
    return msg;
  }
}

class HttpResponseLog extends TalkerLog {
  HttpResponseLog(
    String title, {
    required this.headers,
    required this.settings,
    this.responseMessage,
    this.data,
  }) : super(title);

  final String? responseMessage;
  final dynamic data;
  final Map<String, dynamic> headers;
  final TalkerDioLoggerSettings settings;

  @override
  AnsiPen get pen => settings.responsePen ?? AnsiPen()
    ..xterm(46);

  @override
  String get title => 'HTTP-RESPONSE';

  @override
  String generateTextMessage() {
    var msg = '[$displayTitle] $message';

    if (settings.printResponseMessage && responseMessage != null) {
      msg += '\nMESSAGE:$responseMessage';
    }

    if (settings.printResponseData && data != null) {
      final prettyData = encoder.convert(data);
      msg += '\nDATA:$prettyData';
    }
    if (settings.printResponseHeaders && headers.isNotEmpty) {
      final prettyHeaders = encoder.convert(headers);
      msg += '\nHEADERS:$prettyHeaders';
    }
    return msg;
  }
}
