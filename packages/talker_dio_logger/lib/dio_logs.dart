import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

const _encoder = JsonEncoder.withIndent('  ');
const _hiddenValue = '*****';

const kDioLogsTimeStampKey = '_talker_dio_logger_ts_';

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
    final headers = Map.from(requestOptions.headers);

    try {
      if (settings.printRequestData && data != null) {
        final prettyData = _encoder.convert(data);
        msg += '\nData: $prettyData';
      }

      if (settings.printRequestHeaders && headers.isNotEmpty) {
        // HTTP headers are case-insensitive by standard
        _replaceHiddenHeaders(headers);

        final prettyHeaders = _encoder.convert(headers);
        msg += '\nHeaders: $prettyHeaders';
      }
    } catch (_) {
      // TODO: add handling can`t convert
    }
    return msg;
  }

  void _replaceHiddenHeaders(Map<dynamic, dynamic> headers) {
    // HTTP headers are case-insensitive by standard
    final lowerCaseHeaders = <String, String>{};
    headers.forEach((key, value) {
      lowerCaseHeaders[key.toLowerCase()] = key;
    });

    for (final hiddenHeader in settings.hiddenHeaders) {
      final lowerCaseHiddenHeader = hiddenHeader.toLowerCase();
      if (lowerCaseHeaders.containsKey(lowerCaseHiddenHeader)) {
        final originalHeader = lowerCaseHeaders[lowerCaseHiddenHeader]!;
        headers[originalHeader] = _hiddenValue;
      }
    }
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
    final responseTime = _getResponseTime(response.requestOptions);

    var msg = '[$title] [${response.requestOptions.method}] [$responseTime ms] $message';

    final responseMessage = response.statusMessage;
    final data = response.data;
    final headers = response.headers.map;
    final redirects = response.redirects;

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

      if (settings.printResponseRedirects && redirects.isNotEmpty) {
        final prettyRedirects = redirects.map((redirect) {
          return '[${redirect.statusCode} ${redirect.method} - ${redirect.location}]';
        }).join('\n');
        msg += '\nRedirects:\n$prettyRedirects';
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
    final responseTime = _getResponseTime(dioException.requestOptions);

    var msg = '[$title] [${dioException.requestOptions.method}] [$responseTime ms] $message';

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

///
/// Get response time
///
int _getResponseTime(RequestOptions options) {
  final triggerTime = options.extra[kDioLogsTimeStampKey];

  if (triggerTime is int) {
    return DateTime.now().millisecondsSinceEpoch - triggerTime;
  }

  return -1;
}
