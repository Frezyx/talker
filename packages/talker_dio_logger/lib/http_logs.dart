import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

const encoder = JsonEncoder.withIndent('  ');

class HttpRequestLog extends FlutterTalkerLog {
  HttpRequestLog(
    String message, {
    required this.headers,
    this.data,
    this.printData = false,
    this.printHeaders = false,
    this.showDataAtUI = true,
    this.showHeadersAtUI = true,
  }) : super(message);

  final dynamic data;
  final Map<String, dynamic> headers;
  final bool printData;
  final bool printHeaders;
  final bool showDataAtUI;
  final bool showHeadersAtUI;

  @override
  AnsiPen get pen => AnsiPen()..xterm(219);

  @override
  Color get color => Colors.pink[300]!;

  @override
  String get title => 'HTTP';

  @override
  String generateTextMessage() {
    var msg = '[$displayTitle] $message';

    if (printData) {
      final prettyData = encoder.convert(data);
      msg += '\nDATA:$prettyData';
    }
    if (printHeaders) {
      final prettyHeaders = encoder.convert(headers);
      msg += '\nHEADERS:$prettyHeaders';
    }
    return msg;
  }

  @override
  String generateFlutterTextMessage() {
    var msg = '[$displayTitle] $message';

    if (showDataAtUI) {
      final prettyData = encoder.convert(data);
      msg += '\nDATA:$prettyData';
    }
    if (showHeadersAtUI) {
      final prettyHeaders = encoder.convert(headers);
      msg += '\nHEADERS:$prettyHeaders';
    }
    return msg;
  }
}

class HttpResponseLog extends FlutterTalkerLog {
  HttpResponseLog(
    String message, {
    required this.headers,
    this.data,
    this.printData = false,
    this.printHeaders = false,
    this.showDataAtUI = true,
    this.showHeadersAtUI = true,
  }) : super(message);

  final dynamic data;
  final Map<String, dynamic> headers;
  final bool printData;
  final bool printHeaders;
  final bool showDataAtUI;
  final bool showHeadersAtUI;

  @override
  AnsiPen get pen => AnsiPen()..xterm(46);

  @override
  Color get color => const Color.fromARGB(255, 48, 227, 57);

  @override
  String get title => 'HTTP-RESPONSE';

  @override
  String generateTextMessage() {
    var msg = '[$displayTitle] $message';

    if (printData && data != null) {
      final prettyData = encoder.convert(data);
      msg += '\nDATA:$prettyData';
    }
    if (printHeaders && headers.isNotEmpty) {
      final prettyHeaders = encoder.convert(headers);
      msg += '\nHEADERS:$prettyHeaders';
    }
    return msg;
  }

  @override
  String generateFlutterTextMessage() {
    var msg = '[$displayTitle] $message';

    if (showDataAtUI) {
      final prettyData = encoder.convert(data);
      msg += '\nDATA:$prettyData';
    }
    if (showHeadersAtUI) {
      final prettyHeaders = encoder.convert(headers);
      msg += '\nHEADERS:$prettyHeaders';
    }
    return msg;
  }
}
