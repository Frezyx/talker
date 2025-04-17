import 'dart:convert' show JsonEncoder;

import 'package:chopper/chopper.dart' show ChopperException, Request, Response;
import 'package:http/http.dart' as http show BaseRequest, Request;
import 'package:talker/talker.dart';
import 'package:talker_chopper_logger/talker_chopper_logger_interceptor.dart';
import 'package:talker_chopper_logger/talker_chopper_logger_settings.dart';

const JsonEncoder _encoder = JsonEncoder.withIndent('  ');
const String _hiddenValue = '*****';

class ChopperRequestLog extends TalkerLog {
  ChopperRequestLog(
    super.message, {
    required this.request,
    required this.settings,
  });

  final http.BaseRequest request;
  final TalkerChopperLoggerSettings settings;

  @override
  AnsiPen get pen => settings.requestPen ?? (AnsiPen()..xterm(219));

  @override
  String get key => TalkerLogType.httpRequest.key;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final StringBuffer msg =
        StringBuffer('[$title] [${request.method}] $message');

    final Map<String, String> headers = {...request.headers};

    try {
      if (settings.printRequestData) {
        switch (request) {
          case http.Request req:
            if (req.body.isNotEmpty) {
              msg.write('\nData: ${_encoder.convert(req.body)}');
            }
            break;
          case Request req:
            if (req.body != null) {
              msg.write('\nData: ${_encoder.convert(req.body)}');
            }
            break;
        }
      }

      if (settings.printRequestHeaders && headers.isNotEmpty) {
        // HTTP headers are case-insensitive by standard
        _replaceHiddenHeaders(headers);

        msg.write('\nHeaders: ${_encoder.convert(headers)}');
      }
    } catch (_) {
      // TODO: add handling can`t convert
    }
    return msg.toString();
  }

  void _replaceHiddenHeaders(Map<String, String> headers) {
    // HTTP headers are case-insensitive by standard
    final Map<String, String> lowerCaseHeaders = headers.map(
      (String key, String value) => MapEntry(key.toLowerCase(), key),
    );

    for (final String hiddenHeader in settings.hiddenHeaders) {
      final String lowerCaseHiddenHeader = hiddenHeader.toLowerCase();
      if (lowerCaseHeaders.containsKey(lowerCaseHiddenHeader)) {
        final String originalHeader = lowerCaseHeaders[lowerCaseHiddenHeader]!;
        headers[originalHeader] = _hiddenValue;
      }
    }
  }
}

class ChopperResponseLog<BodyType> extends TalkerLog {
  ChopperResponseLog(
    String super.message, {
    required this.response,
    required this.settings,
  });

  final Response<BodyType> response;
  final TalkerChopperLoggerSettings settings;

  @override
  AnsiPen get pen => settings.responsePen ?? (AnsiPen()..xterm(46));

  @override
  String get key => TalkerLogType.httpResponse.key;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final StringBuffer msg =
        StringBuffer('[$title] [${response.base.request?.method}] $message');

    final String? responseMessage = response.base.reasonPhrase;
    final BodyType? data = response.body;
    final Map<String, String> headers = response.headers;
    final bool isRedirect = response.base.isRedirect;

    msg.write('\nStatus: ${response.statusCode}');

    if (settings.printResponseTime) {
      final int? responseTime = _getResponseTime(response.headers);

      if (responseTime != null) {
        msg.write('\nTime: $responseTime ms');
      }
    }

    if (settings.printResponseMessage && responseMessage != null) {
      msg.write('\nMessage: $responseMessage');
    }

    try {
      if (settings.printResponseData && data != null) {
        msg.write('\nData: ${_encoder.convert(data)}');
      }
      if (settings.printResponseHeaders && headers.isNotEmpty) {
        msg.write('\nHeaders: ${_encoder.convert(headers)}');
      }

      if (settings.printResponseRedirects && isRedirect) {
        msg.write('\nRedirect: $isRedirect');
      }
    } catch (_) {
      // TODO: add handling can`t convert
    }
    return msg.toString();
  }
}

class ChopperErrorLog<BodyType> extends TalkerLog {
  ChopperErrorLog(
    String super.title, {
    required this.chopperException,
    required this.settings,
  });

  final ChopperException chopperException;
  final TalkerChopperLoggerSettings settings;

  @override
  AnsiPen get pen => settings.errorPen ?? (AnsiPen()..red());

  @override
  String get key => TalkerLogType.httpError.key;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final StringBuffer msg = StringBuffer(
        '[$title] [${chopperException.response?.base.request?.method ?? chopperException.request?.method}] $message');

    final String responseMessage = chopperException.message;
    final int? statusCode = chopperException.response?.statusCode;
    final BodyType? body = chopperException.response?.body;
    final Map<String, String>? headers = chopperException.response?.headers;

    if (statusCode != null) {
      msg.write('\nStatus: $statusCode');
    }

    if (settings.printResponseTime && (headers?.isNotEmpty ?? false)) {
      final int? responseTime = _getResponseTime(headers!);

      if (responseTime != null) {
        msg.write('\nTime: $responseTime ms');
      }
    }

    if (settings.printErrorMessage &&
        responseMessage.isNotEmpty &&
        responseMessage != 'null') {
      msg.write('\nMessage: $responseMessage');
    }

    if (settings.printErrorData && body != null) {
      msg.write('\nData: ${_encoder.convert(body)}');
    }
    if (settings.printErrorHeaders && (headers?.isNotEmpty ?? false)) {
      msg.write('\nHeaders: ${_encoder.convert(headers)}');
    }
    return msg.toString();
  }
}

///
/// Get response time
///
int? _getResponseTime(Map<String, String> headers) {
  final int? triggerTime =
      int.tryParse(headers[TalkerChopperLogger.kChopperLogsTimeStampKey] ?? '');

  if (triggerTime is int) {
    return DateTime.timestamp().millisecondsSinceEpoch - triggerTime;
  }

  return null;
}
