import 'dart:convert' show JsonEncoder, jsonDecode;

import 'package:http_interceptor/http_interceptor.dart';
import 'package:meta/meta.dart';
import 'package:talker/talker.dart';
import 'package:talker_http_logger/curl_request.dart';
import 'package:talker_http_logger/talker_http_logger_settings.dart';

class HttpRequestLog extends TalkerLog {
  HttpRequestLog(
    super.title, {
    required this.request,
    required this.settings,
  });

  final BaseRequest request;
  final TalkerHttpLoggerSettings settings;

  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');
  static const String _hiddenValue = '*****';

  @override
  AnsiPen get pen => settings.requestPen ?? (AnsiPen()..xterm(219));

  @override
  String get key => TalkerLogType.httpRequest.key;

  @override
  LogLevel get logLevel => settings.logLevel;

  @visibleForTesting
  String convert(Object? object) => _encoder.convert(object);

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

    if (settings.printRequestHeaders && headers.isNotEmpty) {
      try {
        msg.writeln('Headers: ${convert(headers)}');
      } catch (error, stackTrace) {
        msg.writeln(
          'Headers: <failed to convert headers: $error\nstackTrace: $stackTrace>',
        );
      }
    }

    if (settings.printRequestData) {
      switch (request) {
        case Request req when req.body.isNotEmpty:
          late final dynamic jsonData;
          try {
            jsonData = jsonDecode(req.body);
          } catch (_) {
            jsonData = null;
          }

          try {
            if (jsonData != null) {
              msg.writeln('Data: ${convert(jsonData)}');
              break;
            } else {
              msg.writeln('Data: ${req.body}');
              break;
            }
          } catch (error, stackTrace) {
            msg.writeln(
              'Data: <failed to convert data: $error\nstackTrace: $stackTrace>',
            );
          }
          break;
        case MultipartRequest req
            when req.fields.isNotEmpty || req.files.isNotEmpty:
          msg.writeln('Data: ${convert(
            {
              ...req.fields,
              for (final MultipartFile file in req.files)
                file.field: file.filename ?? ''
            },
          )}');
          break;
        default:
          break;
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
