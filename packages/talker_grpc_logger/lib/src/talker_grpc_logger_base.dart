import 'package:grpc/grpc.dart';
import 'package:talker/talker.dart';

import 'grpc_logs.dart';

/// {@template talker_grpc_logger}
/// A gRPC [ClientInterceptor] implementation that logs gRPC requests,
/// responses, and errors using the [Talker] logger.
///
/// This interceptor captures:
/// - Unary request data (method path, payload, options)
/// - Response data (including duration)
/// - gRPC errors (with optional token obfuscation)
///
/// Example usage:
/// ```dart
/// final channel = ClientChannel(
///   'localhost',
///   port: 50051,
///   options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
/// );
///
/// final client = MyGrpcClient(channel, interceptors: [TalkerGrpcLogger()]);
/// ```
/// {@endtemplate}
class TalkerGrpcLogger extends ClientInterceptor {
  /// Creates a [TalkerGrpcLogger].
  ///
  /// If a [talker] instance is not provided, a default one will be created.
  ///
  /// If [obfuscateToken] is `true`, attempts to hide sensitive information
  /// (such as bearer tokens) from logs.
  TalkerGrpcLogger({
    Talker? talker,
    this.obfuscateToken = true,
  }) {
    _talker = talker ?? Talker();
  }

  late final Talker _talker;

  /// If `true`, sensitive token information in metadata will be obfuscated.
  final bool obfuscateToken;

  /// Intercepts and logs unary (single request - single response) gRPC calls.
  ///
  /// Logs:
  /// - Outgoing request details
  /// - Response details upon success
  /// - Error details upon failure
  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    _talker.logCustom(
      GrpcRequestLog(
        method.path,
        method: method,
        request: request,
        options: options,
        obfuscateToken: obfuscateToken,
      ),
    );

    final startTime = DateTime.now();
    final response = invoker(method, request, options);

    response.then((r) {
      final elapsedTime = DateTime.now().difference(startTime);
      _talker.logCustom(
        GrpcResponseLog(
          method.path,
          method: method,
          response: r,
          durationMs: elapsedTime.inMilliseconds,
        ),
      );
    }).catchError((e) {
      final elapsedTime = DateTime.now().difference(startTime);
      _talker.logCustom(
        GrpcErrorLog(
          method.path,
          method: method,
          request: request,
          options: options,
          grpcError: e,
          durationMs: elapsedTime.inMilliseconds,
          obfuscateToken: obfuscateToken,
        ),
      );
    });

    return response;
  }

  /// Intercepts streaming gRPC calls (client-streaming or bidirectional).
  ///
  /// Currently, this method only prints a message and forwards the request.
  /// You can extend this to handle logging of streaming requests/responses.
  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    // TODO: Add streaming request/response logging if needed.
    print('interceptStreaming: ${method.path}');
    return invoker(method, requests, options);
  }
}
