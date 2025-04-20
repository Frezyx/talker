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
    final StringBuffer msg = StringBuffer();
    msg.write('[$title]');
    msg.write(' [${request.method}]');
    msg.writeln(' $message');

    final Map<String, String> headers = {...request.headers};

    // HTTP headers are case-insensitive by standard
    _replaceHiddenHeaders(headers);

    if (settings.printRequestCurl) {
      msg.writeln('[cURL] ${request.toCurl(headers: headers)}');
    }

    if (settings.printRequestData) {
      switch (request) {
        case http.Request req when req.body.isNotEmpty:
          try {
            // Try to decode the body as JSON
            msg.writeln('Data: ${_encoder.convert(jsonDecode(req.body))}');
          } on FormatException {
            // Return original text if it’s not valid JSON
            msg.writeln('Data: ${req.body}');
          } catch (error, stackTrace) {
            msg.writeln('Data: <failed to convert data: $error>');
            print('Error converting data: $error\n$stackTrace');
          }
          break;
        case http.MultipartRequest req
            when req.fields.isNotEmpty || req.files.isNotEmpty:
          msg.writeln('Data: ${_encoder.convert(
            {
              ...req.fields,
              for (final http.MultipartFile file in req.files)
                file.field: file.filename ?? ''
            },
          )}');
          break;
        case Request req when req.body != null:
          try {
            msg.writeln('Data: ${_encoder.convert(req.body)}');
          } catch (error, stackTrace) {
            msg.writeln('Data: <failed to convert data: $error>');
            print('Error converting data: $error\n$stackTrace');
          }
          break;
        default:
          break;
      }
    }

    if (settings.printRequestHeaders && headers.isNotEmpty) {
      try {
        msg.writeln('Headers: ${_encoder.convert(headers)}');
      } catch (error, stackTrace) {
        msg.writeln('Headers: <failed to convert headers: $error>');
        print('Error converting headers: $error\n$stackTrace');
      }
    }

    return msg.toString().trimRight();
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
    this.request,
    required this.response,
    required this.settings,
    this.responseTime = 0,
  });

  final Request? request;
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

    if (settings.printResponseData && data != null) {
      try {
        msg.writeln('Data: ${_encoder.convert(data)}');
      } catch (error, stackTrace) {
        msg.writeln('Data: <failed to convert data: $error>');
        print('Error converting data: $error\n$stackTrace');
      }
    }

    if (settings.printResponseHeaders && headers.isNotEmpty) {
      try {
        msg.writeln('Headers: ${_encoder.convert(headers)}');
      } catch (error, stackTrace) {
        msg.writeln('Headers: <failed to convert headers: $error>');
        print('Error converting headers: $error\n$stackTrace');
      }
    }

    if (settings.printResponseRedirects && isRedirect) {
      msg.writeln('Redirect: $isRedirect');
    }
    return msg.toString().trimRight();
  }
}

class ChopperErrorLog<BodyType> extends TalkerLog {
  ChopperErrorLog(
    super.title, {
    this.request,
    required this.chopperException,
    required this.settings,
    this.responseTime = 0,
    super.stackTrace,
  }) : super(exception: chopperException);

  final Request? request;
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
    final StringBuffer msg = StringBuffer();

    msg.write('[$title]');
    if (chopperException.response?.base.request?.method != null ||
        chopperException.request?.method != null) {
      msg.write(
        ' [${chopperException.response?.base.request?.method ?? chopperException.request?.method}]',
      );
    }
    if (chopperException.response?.base.request?.url != null ||
        chopperException.request?.url != null ||
        request?.url != null) {
      msg.write(
        ' ${chopperException.response?.base.request?.url ?? chopperException.request?.url ?? request?.url}',
      );
    }
    msg.writeln();

    final String responseMessage = chopperException.message;
    final int? statusCode = chopperException.response?.statusCode;
    final BodyType? body = chopperException.response?.body;
    final Map<String, String>? headers = chopperException.response?.headers;

    if (statusCode != null) {
      msg.writeln('Status: $statusCode');
    }

    if (settings.printResponseTime) {
      msg.writeln('Time: $responseTime ms');
    }

    if (settings.printErrorMessage &&
        responseMessage.isNotEmpty &&
        responseMessage != 'null') {
      msg.writeln('Message: $responseMessage');
    }

    if (settings.printErrorData && body != null) {
      msg.writeln('Data: ${_encoder.convert(body)}');
    }
    if (settings.printErrorHeaders && (headers?.isNotEmpty ?? false)) {
      msg.writeln('Headers: ${_encoder.convert(headers)}');
    }
    return msg.toString().trimRight();
  }
}
