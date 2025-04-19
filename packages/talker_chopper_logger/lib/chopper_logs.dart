import 'dart:convert' show JsonEncoder, jsonDecode;

import 'package:chopper/chopper.dart' show ChopperException, Request, Response;
import 'package:http/http.dart' as http
    show BaseRequest, MultipartFile, MultipartRequest, Request;
import 'package:talker/talker.dart';
import 'package:talker_chopper_logger/curl_request.dart';
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
  LogLevel get logLevel => settings.logLevel;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final StringBuffer msg =
        StringBuffer('[$title] [${request.method}] $message');

    final Map<String, String> headers = {...request.headers};

    // HTTP headers are case-insensitive by standard
    _replaceHiddenHeaders(headers);

    if (settings.printRequestCurl) {
      msg.write('\n[cURL] ${request.toCurl(headers: headers)}');
    }

    try {
      if (settings.printRequestData) {
        switch (request) {
          case http.Request req when req.body.isNotEmpty:
            try {
              // Try to decode the body as JSON
              msg.write('\nData: ${_encoder.convert(jsonDecode(req.body))}');
            } on FormatException {
              // Return original text if it’s not valid JSON
              msg.write('\nData: ${req.body}');
            }
            break;
          case http.MultipartRequest req
              when req.fields.isNotEmpty || req.files.isNotEmpty:
            msg.write('\nData: ${_encoder.convert(
              {
                ...req.fields,
                for (final http.MultipartFile file in req.files)
                  file.field: file.filename ?? ''
              },
            )}');
            break;
          case Request req when req.body != null:
            msg.write('\nData: ${_encoder.convert(req.body)}');
            break;
          default:
            break;
        }
      }

      // HTTP headers are case-insensitive by standard
      _replaceHiddenHeaders(headers);

      if (settings.printRequestHeaders && headers.isNotEmpty) {
        msg.write('\nHeaders: ${_encoder.convert(headers)}');
      }
    } catch (_) {
      // TODO: add handling can`t convert
    }
    return msg.toString();
  }

  void _replaceHiddenHeaders(Map<String, String> headers) {
    if (settings.hiddenHeaders.isEmpty || headers.isEmpty) {
      return;
    }

    // HTTP headers are case-insensitive by standard
    final Set<String> hiddenLower = settings.hiddenHeaders
        .map((String header) => header.toLowerCase())
        .toSet();

    headers.updateAll((String k, String v) =>
        hiddenLower.contains(k.toLowerCase()) ? _hiddenValue : v);
  }
}

class ChopperResponseLog<BodyType> extends TalkerLog {
  ChopperResponseLog(
    String super.message, {
    required this.response,
    required this.settings,
    this.responseTime = 0,
  });

  final Response<BodyType> response;
  final TalkerChopperLoggerSettings settings;
  final int responseTime;

  @override
  AnsiPen get pen => settings.responsePen ?? (AnsiPen()..xterm(46));

  @override
  String get key => TalkerLogType.httpResponse.key;

  @override
  LogLevel get logLevel => settings.logLevel;

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
      msg.write('\nTime: $responseTime ms');
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
    this.responseTime = 0,
  });

  final ChopperException chopperException;
  final TalkerChopperLoggerSettings settings;
  final int responseTime;

  @override
  AnsiPen get pen => settings.errorPen ?? (AnsiPen()..red());

  @override
  String get key => TalkerLogType.httpError.key;

  @override
  LogLevel get logLevel => LogLevel.error;

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

    if (settings.printResponseTime) {
      msg.write('\nTime: $responseTime ms');
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
