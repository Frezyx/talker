import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:talker/talker.dart';

const _encoder = JsonEncoder.withIndent('  ');

/// {@template grpc_request_log}
/// A [TalkerLog] implementation that logs outgoing gRPC unary request data.
///
/// Includes:
/// - Request method path
/// - Request payload (as string)
/// - gRPC metadata (headers), with optional token obfuscation
/// {@endtemplate}
class GrpcRequestLog<Q, R> extends TalkerLog {
  /// {@macro grpc_request_log}
  GrpcRequestLog(
    String title, {
    required this.method,
    required this.request,
    required this.options,
    this.obfuscateToken = true,
  }) : super(title);

  /// The gRPC method being called.
  final ClientMethod<Q, R> method;

  /// The request payload.
  final Q request;

  /// gRPC call options, including metadata headers.
  final CallOptions options;

  /// Whether to hide sensitive tokens like `Authorization` from the logs.
  final bool obfuscateToken;

  @override
  AnsiPen get pen => (AnsiPen()..xterm(219)); // Violet-ish color for requests

  @override
  String get key => TalkerKey.grpcRequest;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final time = TalkerDateTimeFormatter(
      DateTime.now(),
      timeFormat: timeFormat,
    ).timeAndSeconds;

    var msg = '[$title] | $time | [${method.path}]';
    msg += '\nRequest: ${request.toString().replaceAll("\n", " ")}';

    // Prepare and sanitize headers
    final headers = <String, String>{};
    for (final entry in options.metadata.entries) {
      if (obfuscateToken && entry.key.toLowerCase() == 'authorization') {
        headers[entry.key] = 'Bearer [obfuscated]';
      } else {
        headers[entry.key] = entry.value;
      }
    }

    try {
      if (headers.isNotEmpty) {
        msg += '\nHeaders: ${_encoder.convert(headers)}';
      }
    } catch (_) {
      // Optionally handle header encoding failure
    }

    return msg;
  }
}

/// {@template grpc_error_log}
/// A [TalkerLog] implementation that logs gRPC errors when requests fail.
///
/// Includes:
/// - Method path
/// - Duration of the request
/// - Error code and message
/// - Request payload and headers (with optional obfuscation)
/// {@endtemplate}
class GrpcErrorLog<Q, R> extends TalkerLog {
  /// {@macro grpc_error_log}
  GrpcErrorLog(
    String title, {
    required this.method,
    required this.request,
    required this.options,
    required this.grpcError,
    required this.durationMs,
    this.obfuscateToken = true,
  }) : super(title);

  /// The gRPC method that failed.
  final ClientMethod<Q, R> method;

  /// The request that triggered the error.
  final Q request;

  /// gRPC call options (including metadata).
  final CallOptions options;

  /// The caught [GrpcError].
  final GrpcError grpcError;

  /// Request duration in milliseconds.
  final int durationMs;

  /// Whether to hide sensitive tokens like `Authorization` from the logs.
  final bool obfuscateToken;

  @override
  AnsiPen get pen => (AnsiPen()..red()); // Red color for errors

  @override
  String get key => TalkerKey.grpcError;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final time = TalkerDateTimeFormatter(
      DateTime.now(),
      timeFormat: timeFormat,
    ).timeAndSeconds;

    var msg = '[$title] | $time | [${method.path}]';
    msg += '\nDuration: $durationMs ms';
    msg += '\nError code: ${grpcError.codeName}';
    msg += '\nError message: ${grpcError.message}';
    msg += '\nRequest: ${request.toString().replaceAll("\n", " ")}';

    // Prepare and sanitize headers
    final headers = <String, String>{};
    for (final entry in options.metadata.entries) {
      if (obfuscateToken && entry.key.toLowerCase() == 'authorization') {
        headers[entry.key] = 'Bearer [obfuscated]';
      } else {
        headers[entry.key] = entry.value;
      }
    }

    try {
      if (headers.isNotEmpty) {
        msg += '\nHeaders: ${_encoder.convert(headers)}';
      }
    } catch (_) {
      // Optionally handle header encoding failure
    }

    return msg;
  }
}

/// {@template grpc_response_log}
/// A [TalkerLog] implementation that logs successful gRPC responses.
///
/// Includes:
/// - Method path
/// - Request duration
/// - Response payload (optional - not shown here for brevity)
/// {@endtemplate}
class GrpcResponseLog<Q, R> extends TalkerLog {
  /// {@macro grpc_response_log}
  GrpcResponseLog(
    String title, {
    required this.method,
    required this.response,
    required this.durationMs,
  }) : super(title);

  /// The gRPC method that was called.
  final ClientMethod<Q, R> method;

  /// The response payload.
  final R response;

  /// Time taken to receive the response, in milliseconds.
  final int durationMs;

  @override
  AnsiPen get pen => (AnsiPen()..xterm(46)); // Green for successful responses

  @override
  String get key => TalkerKey.grpcResponse;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final time = TalkerDateTimeFormatter(
      DateTime.now(),
      timeFormat: timeFormat,
    ).timeAndSeconds;

    var msg = '[$title] | $time | [${method.path}]';
    msg += '\nDuration: $durationMs ms';
    return msg;
  }
}
