import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

const _encoder = JsonEncoder.withIndent('  ');
const _hiddenValue = '*****';

class DioRequestLog extends TalkerLog {
  DioRequestLog(
    String message, {
    required this.requestOptions,
    required this.settings,
  }) : super(message);

  final RequestOptions requestOptions;
  final TalkerDioLoggerSettings settings;

  @override
  AnsiPen get pen => settings.requestPen ?? (AnsiPen()..xterm(219));

  @override
  String get key => TalkerLogType.httpRequest.key;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    var msg = '[$title] [${requestOptions.method}] $message';

    final data = requestOptions.data;
    final headers = requestOptions.headers;

    try {
      if (settings.printRequestData && data != null) {
        final prettyData = _encoder.convert(data);
        msg += '\nData: $prettyData';
      }
      if (settings.printRequestHeaders && headers.isNotEmpty) {
        final hiddenHeaders = settings.hiddenHeaders;
        if (hiddenHeaders.isNotEmpty) {
          for (final e in hiddenHeaders) {
            if (headers.containsKey(e)) {
              headers[e] = _hiddenValue;
            }
          }
        }

        final prettyHeaders = _encoder.convert(headers);
        msg += '\nHeaders: $prettyHeaders';
      }
    } catch (_) {
      // TODO: add handling can`t convert
    }
    return msg;
  }
}

class DioResponseLog extends TalkerLog {
  DioResponseLog(
    String message, {
    required this.response,
    required this.settings,
  }) : super(message);

  final Response<dynamic> response;
  final TalkerDioLoggerSettings settings;

  @override
  AnsiPen get pen => settings.responsePen ?? (AnsiPen()..xterm(46));

  @override
  String get key => TalkerLogType.httpResponse.key;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    var msg = '[$title] [${response.requestOptions.method}] $message';

    final responseMessage = response.statusMessage;
    final data = response.data;
    final headers = response.headers.map;

    msg += '\nStatus: ${response.statusCode}';

    if (settings.printResponseMessage && responseMessage != null) {
      msg += '\nMessage: $responseMessage';
    }

    try {
      if (settings.printResponseData && data != null) {
        final prettyData = _encoder.convert(data);
        msg += '\nData: $prettyData';
      }
      if (settings.printResponseHeaders && headers.isNotEmpty) {
        final prettyHeaders = _encoder.convert(headers);
        msg += '\nHeaders: $prettyHeaders';
      }
    } catch (_) {
      // TODO: add handling can`t convert
    }
    return msg;
  }
}

class DioErrorLog extends TalkerLog {
  DioErrorLog(
    String title, {
    required this.dioException,
    required this.settings,
  }) : super(title);

  final DioException dioException;
  final TalkerDioLoggerSettings settings;

  @override
  AnsiPen get pen => settings.errorPen ?? (AnsiPen()..red());

  @override
  String get key => TalkerLogType.httpError.key;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    var msg = '[$title] [${dioException.requestOptions.method}] $message';

    final responseMessage = dioException.message;
    final statusCode = dioException.response?.statusCode;
    final data = dioException.response?.data;
    final headers = dioException.response?.headers;

    if (statusCode != null) {
      msg += '\nStatus: ${dioException.response?.statusCode}';
    }

    if (settings.printErrorMessage && responseMessage != null) {
      msg += '\nMessage: $responseMessage';
    }

    if (settings.printErrorData && data != null) {
      final prettyData = _encoder.convert(data);
      msg += '\nData: $prettyData';
    }
    if (settings.printErrorHeaders && !(headers?.isEmpty ?? true)) {
      final prettyHeaders = _encoder.convert(headers!.map);
      msg += '\nHeaders: $prettyHeaders';
    }
    return msg;
  }
}
