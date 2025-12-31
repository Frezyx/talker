import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

const _encoder = JsonEncoder.withIndent('  ');
const _hiddenValue = '*****';

String _formatData(dynamic data, TalkerDioLoggerSettings settings) {
  if (settings.prettyFormatter != null) {
    return settings.prettyFormatter!(data);
  }
  final json = _encoder.convert(data);
  if (settings.stripJsonQuotes) {
    return json
        .replaceAll(r'\"', '\x00')
        .replaceAll('"', '')
        .replaceAll('\x00', '"');
  }
  return json;
}

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
  String get key => TalkerKey.httpRequest;

  @override
  LogLevel get logLevel => settings.logLevel;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    var msg = '[$title] [${requestOptions.method}] $message';

    final data = requestOptions.data;
    final headers = Map.from(requestOptions.headers);

    try {
      if (settings.printRequestData && data != null) {
        // If data is FormData, convert it to a map for better readability
        if (data is FormData) {
          final formDataMap = <String, dynamic>{};
          for (var field in data.fields) {
            formDataMap[field.key] = field.value;
          }
          for (var file in data.files) {
            formDataMap[file.key] = {
              'filename': file.value.filename,
              'contentType': file.value.contentType.toString(),
              'bytes': file.value.length,
            };
          }

          msg += '\nData: ${_formatData(formDataMap, settings)}';
        } else {
          msg += '\nData: ${_formatData(data, settings)}';
        }
      }

      if (settings.printRequestHeaders && headers.isNotEmpty) {
        // HTTP headers are case-insensitive by standard
        _replaceHiddenHeaders(headers);
        msg += '\nHeaders: ${_formatData(headers, settings)}';
      }

      final extra = Map.from(requestOptions.extra);
      if (settings.printRequestExtra && extra.isNotEmpty) {
        msg += '\nExtra: ${_formatData(extra, settings)}';
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
  })  : responseTime = _getResponseTime(response.requestOptions),
        super(message);

  final Response<dynamic> response;
  final TalkerDioLoggerSettings settings;

  /// Response time in milliseconds, calculated once when the log is created
  final int? responseTime;

  @override
  AnsiPen get pen => settings.responsePen ?? (AnsiPen()..xterm(46));

  @override
  String get key => TalkerKey.httpResponse;

  @override
  LogLevel get logLevel => settings.logLevel;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    var msg = '[$title] [${response.requestOptions.method}] $message';

    final responseMessage = response.statusMessage;
    final data = response.data;
    final headers = response.headers.map;
    final redirects = response.redirects;

    msg += '\nStatus: ${response.statusCode}';

    if (settings.printResponseTime) {
      if (responseTime != null) {
        msg += '\nTime: $responseTime ms';
      }
    }

    if (settings.printResponseMessage && responseMessage != null) {
      msg += '\nMessage: $responseMessage';
    }

    try {
      if (settings.printResponseData && data != null) {
        final prettyData = settings.responseDataConverter?.call(response) ??
            _formatData(data, settings);
        msg += '\nData: $prettyData';
      }
      if (settings.printResponseHeaders && headers.isNotEmpty) {
        msg += '\nHeaders: ${_formatData(headers, settings)}';
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
  })  : responseTime = _getResponseTime(dioException.requestOptions),
        super(title);

  final DioException dioException;
  final TalkerDioLoggerSettings settings;

  /// Response time in milliseconds, calculated once when the log is created
  final int? responseTime;

  @override
  AnsiPen get pen => settings.errorPen ?? (AnsiPen()..red());

  @override
  String get key => TalkerKey.httpError;

  @override
  LogLevel get logLevel => LogLevel.error;

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

    if (settings.printResponseTime) {
      if (responseTime != null) {
        msg += '\nTime: $responseTime ms';
      }
    }

    if (settings.printErrorMessage && responseMessage != null) {
      msg += '\nMessage: $responseMessage';
    }

    if (settings.printErrorData && data != null) {
      msg += '\nData: ${_formatData(data, settings)}';
    }
    if (settings.printErrorHeaders && !(headers?.isEmpty ?? true)) {
      msg += '\nHeaders: ${_formatData(headers!.map, settings)}';
    }
    return msg;
  }
}

///
/// Get response time
///
int? _getResponseTime(RequestOptions options) {
  final triggerTime = options.extra[TalkerDioLogger.kDioLogsTimeStampKey];

  if (triggerTime is int) {
    return DateTime.now().millisecondsSinceEpoch - triggerTime;
  }

  return null;
}
