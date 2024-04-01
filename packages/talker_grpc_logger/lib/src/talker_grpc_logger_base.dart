/// Implements a gRPC interceptor that logs requests and responses to Talker.
/// https://pub.dev/documentation/grpc/latest/grpc/ClientInterceptor-class.html
import 'dart:convert';

import 'package:talker/talker.dart';
import 'package:grpc/grpc.dart';

const encoder = JsonEncoder.withIndent('  ');

class TalkerGrpcLogger extends ClientInterceptor {
  TalkerGrpcLogger({Talker? talker, this.obfuscateToken = true}) {
    _talker = talker ?? Talker();
  }

  late Talker _talker;
  final bool obfuscateToken;

  @override
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
      CallOptions options, ClientUnaryInvoker<Q, R> invoker) {
    _talker.logTyped(GrpcRequestLog(method.path,
        method: method,
        request: request,
        options: options,
        obfuscateToken: obfuscateToken));

    DateTime startTime = DateTime.now();
    final response = invoker(method, request, options);

    response.then((r) {
      Duration elapsedTime = DateTime.now().difference(startTime);
      _talker.logTyped(GrpcResponseLog(method.path,
          method: method, response: r, durationMs: elapsedTime.inMilliseconds));
    }).catchError((e) {
      Duration elapsedTime = DateTime.now().difference(startTime);
      _talker.logTyped(GrpcErrorLog(method.path,
          method: method,
          request: request,
          options: options,
          grpcError: e,
          durationMs: elapsedTime.inMilliseconds,
          obfuscateToken: obfuscateToken));
    });
    return response;
  }

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
      ClientMethod<Q, R> method,
      Stream<Q> requests,
      CallOptions options,
      ClientStreamingInvoker<Q, R> invoker) {
    print('interceptStreaming');

    return invoker(method, requests, options);
  }
}

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
  String generateTextMessage() {
    var time = TalkerDateTimeFormatter(DateTime.now()).timeAndSeconds;
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
  AnsiPen get pen => (AnsiPen()..xterm(219));

  @override
  String get title => 'grpc-error';

  @override
  String generateTextMessage() {
    var time = TalkerDateTimeFormatter(DateTime.now()).timeAndSeconds;
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
  AnsiPen get pen => (AnsiPen()..xterm(219));

  @override
  String get title => 'grpc-response';

  @override
  String generateTextMessage() {
    var time = TalkerDateTimeFormatter(DateTime.now()).timeAndSeconds;
    var msg = '[$title] | $time | [${method.path}]';
    msg += '\nDuration: $durationMs ms';
    return msg;
  }
}
