import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

const encoder = JsonEncoder.withIndent('  ');

class HttpRequestLog extends FlutterTalkerLog {
  HttpRequestLog(
    String title, {
    required this.headers,
    this.data,
    this.printData = false,
    this.printHeaders = false,
    this.showDataAtUI = true,
    this.showHeadersAtUI = true,
  }) : super(title);

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

class HttpResponseLog extends FlutterTalkerLog {
  HttpResponseLog(
    String title, {
    required this.headers,
    this.responseMessage,
    this.data,
    this.printData = false,
    this.printHeaders = false,
    this.printMesage = true,
    this.showDataAtUI = true,
    this.showHeadersAtUI = true,
  }) : super(title);

  final String? responseMessage;
  final dynamic data;
  final Map<String, dynamic> headers;
  final bool printData;
  final bool printHeaders;
  final bool printMesage;
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

    if (printMesage && responseMessage != null) {
      msg += '\nMESSAGE:$responseMessage';
    }

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
