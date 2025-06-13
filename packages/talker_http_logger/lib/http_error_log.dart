import 'dart:convert' show JsonEncoder, jsonDecode;

import 'package:http_interceptor/http_interceptor.dart';
import 'package:meta/meta.dart';
import 'package:talker/talker.dart';
import 'package:talker_http_logger/response_time.dart';
import 'package:talker_http_logger/talker_http_logger_settings.dart';

class HttpErrorLog extends TalkerLog with ResponseTime {
  HttpErrorLog(
    super.title, {
    this.request,
    this.response,
    required this.settings,
    super.exception,
    super.stackTrace,
  });

  final BaseRequest? request;
  final BaseResponse? response;
  final TalkerHttpLoggerSettings settings;

  static const JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  @override
  AnsiPen get pen => settings.errorPen ?? (AnsiPen()..red());

  @override
  String get key => TalkerLogType.httpError.key;

  @override
  LogLevel get logLevel => LogLevel.error;

  @visibleForTesting
  String convert(Object? object) => _encoder.convert(object);

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final StringBuffer msg = StringBuffer();

    msg.write('[$title]');

    if (response?.request?.method != null || request?.method != null) {
      msg.write(' [${response?.request?.method ?? request?.method}]');
    }

    if (response?.request != null || request != null) {
      msg.writeln(' ${response?.request?.url ?? request?.url}');
    } else if (exception is ClientException) {
      msg.writeln(' ${(exception as ClientException).uri}');
    } else {
      msg.writeln();
    }

    if (response?.statusCode != null) {
      msg.writeln('Status: ${response?.statusCode}');
    }

    final String? responseMessage = switch (exception) {
      ClientException ex => ex.message,
      Exception ex => ex.toString(),
      _ => null,
    };

    if (settings.printResponseTime) {
      final int? responseTime = getResponseTime(response?.headers) ??
          getResponseTime(response?.request?.headers);

      if (responseTime != null) {
        msg.writeln('Time: $responseTime ms');
      }
    }

    if (settings.printErrorMessage && (responseMessage?.isNotEmpty ?? false)) {
      msg.writeln('Message: $responseMessage');
    }

    if (settings.printErrorHeaders && (response?.headers.isNotEmpty ?? false)) {
      msg.writeln('Headers: ${convert(response?.headers)}');
    }

    final String? data = switch (response) {
      Response res => res.body,
      _ => null,
    };

    if (settings.printErrorData && (data?.isNotEmpty ?? false)) {
      late final dynamic jsonData;
      try {
        jsonData = jsonDecode(data!);
      } catch (_) {
        jsonData = null;
      }

      try {
        if (jsonData != null) {
          msg.writeln('Data: ${convert(jsonData)}');
        } else {
          msg.writeln('Data: ${convert(data)}');
        }
      } catch (error, stackTrace) {
        msg.writeln(
          'Data: <failed to convert data: $error\nstackTrace: $stackTrace>',
        );
      }
    }

    return msg.toString().trimRight();
  }
}
