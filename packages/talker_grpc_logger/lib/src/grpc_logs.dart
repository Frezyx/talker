import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:talker/talker.dart';

const encoder = JsonEncoder.withIndent('  ');

class GrpcRequestLog<Q, R> extends TalkerLog {
  GrpcRequestLog(
    String title, {
    required this.method,
    required this.request,
    required this.options,
    this.obfuscateToken = true,
  }) : super(title);

  final ClientMethod<Q, R> method;
  final Q request;
  final CallOptions options;
  final bool obfuscateToken;

  @override
  AnsiPen get pen => (AnsiPen()..xterm(219));

  @override
  String get title => 'grpc-request';

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    var time = TalkerDateTimeFormatter(
      DateTime.now(),
      timeFormat: timeFormat,
    ).timeAndSeconds;
    var msg = '[$title] | $time | [${method.path}]';

    msg += '\nRequest: ${request.toString().replaceAll("\n", " ")}';

    // Add the headers to the log message, but obfuscate the token if
    // necessary.
    final Map<String, String> headers = {};
    options.metadata.forEach((key, value) {
      if (obfuscateToken && key.toLowerCase() == 'authorization') {
        headers[key] = 'Bearer [obfuscated]';
      } else {
        headers[key] = value;
      }
    });

    try {
      if (headers.isNotEmpty) {
        final prettyHeaders = encoder.convert(headers);
        msg += '\nHeaders: $prettyHeaders';
      }
    } catch (_) {
      // TODO: add handling can`t convert
    }
    return msg;
  }
}

class GrpcErrorLog<Q, R> extends TalkerLog {
  GrpcErrorLog(
    String title, {
    required this.method,
    required this.request,
    required this.options,
    required this.grpcError,
    required this.durationMs,
    this.obfuscateToken = true,
  }) : super(title);

  final ClientMethod<Q, R> method;
  final Q request;
  final CallOptions options;
  final GrpcError grpcError;
  final int durationMs;
  final bool obfuscateToken;

  @override
  AnsiPen get pen => (AnsiPen()..red());

  @override
  String get title => 'grpc-error';

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    var time = TalkerDateTimeFormatter(
      DateTime.now(),
      timeFormat: timeFormat,
    ).timeAndSeconds;
    var msg = '[$title] | $time | [${method.path}]';
    msg += '\nDuration: $durationMs ms';
    msg += '\nError code: ${grpcError.codeName}';
    msg += '\nError message: ${grpcError.message}';
    msg += '\nRequest: ${request.toString().replaceAll("\n", " ")}';

    // Add the headers to the log message, but obfuscate the token if
    // necessary.
    final Map<String, String> headers = {};
    options.metadata.forEach((key, value) {
      if (obfuscateToken && key.toLowerCase() == 'authorization') {
        headers[key] = 'Bearer [obfuscated]';
      } else {
        headers[key] = value;
      }
    });

    try {
      if (headers.isNotEmpty) {
        final prettyHeaders = encoder.convert(headers);
        msg += '\nHeaders: $prettyHeaders';
      }
    } catch (_) {
      // TODO: add handling can`t convert
    }
    return msg;
  }
}

class GrpcResponseLog<Q, R> extends TalkerLog {
  GrpcResponseLog(
    String title, {
    required this.method,
    required this.response,
    required this.durationMs,
  }) : super(title);

  final ClientMethod<Q, R> method;
  final R response;
  final int durationMs;

  @override
  AnsiPen get pen => (AnsiPen()..xterm(46));

  @override
  String get title => 'grpc-response';

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    var time = TalkerDateTimeFormatter(
      DateTime.now(),
      timeFormat: timeFormat,
    ).timeAndSeconds;
    var msg = '[$title] | $time | [${method.path}]';
    msg += '\nDuration: $durationMs ms';
    return msg;
  }
}
