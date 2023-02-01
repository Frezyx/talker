import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

const encoder = JsonEncoder.withIndent('  ');

class HttpRequestLog extends TalkerLog {
  HttpRequestLog(
    String title, {
    required this.requestOptions,
    required this.settings,
  }) : super(title);

  final RequestOptions requestOptions;
  final TalkerDioLoggerSettings settings;

  @override
  AnsiPen get pen => settings.requestPen ?? (AnsiPen()..xterm(219));

  @override
  String get title => 'http-request';

  @override
  String generateTextMessage() {
    var msg = '[$displayTitle] [${requestOptions.method}] $message';

    final data = requestOptions.data;
    final headers = requestOptions.headers;

    try {
      if (settings.printRequestData && data != null) {
        final prettyData = encoder.convert(data);
        msg += '\nData: $prettyData';
      }
      if (settings.printRequestHeaders && headers.isNotEmpty) {
        final prettyHeaders = encoder.convert(headers);
        msg += '\nHeaders: $prettyHeaders';
      }
    } catch (_) {
      // TODO: add handling can`t convert
    }
    return msg;
  }
}

class HttpResponseLog extends TalkerLog {
  HttpResponseLog(
    String title, {
    required this.response,
    required this.settings,
  }) : super(title);

  final Response<dynamic> response;
  final TalkerDioLoggerSettings settings;

  @override
  AnsiPen get pen => settings.responsePen ?? (AnsiPen()..xterm(46));

  @override
  String get title => 'http-response';

  @override
  String generateTextMessage() {
    var msg = '[$displayTitle] [${response.requestOptions.method}] $message';

    final responseMessage = response.statusMessage;
    final data = response.data;
    final headers = response.requestOptions.headers;

    msg += '\nStatus: ${response.statusCode}';

    if (settings.printResponseMessage && responseMessage != null) {
      msg += '\nMessage: $responseMessage';
    }

    try {
      if (settings.printResponseData && data != null) {
        final prettyData = encoder.convert(data);
        msg += '\nData: $prettyData';
      }
      if (settings.printResponseHeaders && headers.isNotEmpty) {
        final prettyHeaders = encoder.convert(headers);
        msg += '\nHeaders: $prettyHeaders';
      }
    } catch (_) {
      // TODO: add handling can`t convert
    }
    return msg;
  }
}

class HttpErrorLog extends TalkerLog {
  HttpErrorLog(
    String title, {
    required this.dioError,
    required this.settings,
  }) : super(title);

  final DioError dioError;
  final TalkerDioLoggerSettings settings;

  @override
  AnsiPen get pen => settings.errorPen ?? (AnsiPen()..red());

  @override
  String get title => 'http-error';

  @override
  String generateTextMessage() {
    var msg = '[$displayTitle] [${dioError.requestOptions.method}] $message';

    final responseMessage = dioError.message;
    final statusCode = dioError.response?.statusCode;
    final data = dioError.response?.data;
    final headers = dioError.requestOptions.headers;

    if (statusCode != null) {
      msg += '\nStatus: ${dioError.response?.statusCode}';
    }
    msg += '\nMessage: $responseMessage';

    if (data != null) {
      final prettyData = encoder.convert(data);
      msg += '\nData: $prettyData';
    }
    if (headers.isNotEmpty) {
      final prettyHeaders = encoder.convert(headers);
      msg += '\nHeaders: $prettyHeaders';
    }
    return msg;
  }
}
