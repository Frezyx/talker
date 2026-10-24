import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:talker/talker.dart';

import 'grpc_logs/grpc_logs.dart';
import 'intercepted_response_stream.dart';
import 'talker_grpc_logger_settings.dart';

/// {@template talker_grpc_logger}
/// A gRPC [ClientInterceptor] that logs requests, responses, and errors
/// through [Talker].
///
/// Use it by passing an instance into your generated client's
/// `interceptors` list:
///
/// ```dart
/// final channel = ClientChannel(
///   'localhost',
///   port: 50051,
///   options: const ChannelOptions(
///     credentials: ChannelCredentials.insecure(),
///   ),
/// );
///
/// final client = MyGrpcClient(
///   channel,
///   interceptors: [TalkerGrpcLogger()],
/// );
/// ```
///
/// Behavior is controlled by [TalkerGrpcLoggerSettings]. Both unary and
/// streaming calls are supported:
/// - {@macro talker_grpc_logger_intercept_unary}
/// - {@macro talker_grpc_logger_intercept_streaming}
///
/// All emitted entries carry one of the stable [TalkerKey]s:
/// - [TalkerKey.grpcRequest] — outgoing request payloads;
/// - [TalkerKey.grpcResponse] — incoming response payloads;
/// - [TalkerKey.grpcEvent] — streaming lifecycle markers;
/// - [TalkerKey.grpcError] — terminal failures.
/// {@endtemplate}
class TalkerGrpcLogger extends ClientInterceptor {
  /// {@macro talker_grpc_logger}
  ///
  /// If [talker] is not provided, a private default [Talker] instance is
  /// created — logs will still be emitted, but they will be invisible to
  /// any UI bound to a different `Talker`.
  ///
  /// ```dart
  /// final talker = TalkerFlutter.init();
  /// final logger = TalkerGrpcLogger(talker: talker);
  /// ```
  TalkerGrpcLogger({
    Talker? talker,
    this.settings = const TalkerGrpcLoggerSettings(),
    @Deprecated('Use TalkerGrpcLoggerSettings.hiddenHeaders instead.')
    this.obfuscateToken = true,
  }) {
    _talker = talker ?? Talker();
    _talker.settings.registerKeys([
      TalkerKey.grpcEvent,
      TalkerKey.grpcRequest,
      TalkerKey.grpcResponse,
      TalkerKey.grpcError,
    ]);
  }

  late final Talker _talker;

  /// {@template talker_grpc_logger_obfuscate_token}
  /// Deprecated. Use [TalkerGrpcLoggerSettings.hiddenHeaders] instead.
  ///
  /// The old flag only masks the hard-coded `authorization` header.
  /// [TalkerGrpcLoggerSettings.hiddenHeaders] is case-insensitive and
  /// accepts arbitrary keys:
  ///
  /// ```dart
  /// TalkerGrpcLogger(
  ///   settings: const TalkerGrpcLoggerSettings(
  ///     hiddenHeaders: {'authorization', 'x-api-key'},
  ///   ),
  /// );
  /// ```
  /// {@endtemplate}
  @Deprecated('Use TalkerGrpcLoggerSettings.hiddenHeaders instead.')
  final bool obfuscateToken;

  /// {@macro talker_grpc_logger_settings}
  final TalkerGrpcLoggerSettings settings;

  /// {@template talker_grpc_logger_intercept_unary}
  /// Intercepts a unary (single request → single response) call.
  ///
  /// Emits, in order:
  /// - a request log before the call is dispatched;
  /// - on success, a response log with the elapsed time;
  /// - on failure, an error log with the same elapsed time.
  ///
  /// The [ResponseFuture] returned by [invoker] is passed through untouched,
  /// so callers see exactly the object they would without the interceptor.
  /// Logging is a side effect and never delays the return value.
  ///
  /// Skipped entirely when [TalkerGrpcLoggerSettings.enabled] is `false` —
  /// in that case the call goes straight to [invoker].
  ///
  /// ```dart
  /// final response = await client.sayHello(HelloRequest(name: 'world'));
  ///
  /// // Logs (in the console / Talker UI):
  /// // [grpc-request]  | [UNARY] /MyService/SayHello
  /// // Headers: {
  /// //   "x-tenant-id": "acme"
  /// // }
  /// // Data: {
  /// //   "name": "world"
  /// // }
  ///
  /// // [grpc-response] | [UNARY] /MyService/SayHello
  /// // Duration: 3 ms
  /// // Data: {
  ///      "message": "Hello world"
  ///    }
  /// ```
  /// {@endtemplate}
  ///
  /// {@macro talker_grpc_logger_intercept_unary}
  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    if (!settings.enabled) {
      return invoker(method, request, options);
    }

    _talker.logCustom(
      GrpcRequestLog.unary(
        method: method,
        request: request,
        options: options,
        settings: settings,
      ),
    );

    final startTime = DateTime.now();
    final response = invoker(method, request, options);

    unawaited(
      response.then(
        (r) {
          _talker.logCustom(
            GrpcResponseLog.unary(
              method: method,
              response: r,
              durationMs: DateTime.now().difference(startTime).inMilliseconds,
              options: options,
              settings: settings,
            ),
          );
        },
        onError: (Object e, StackTrace _) {
          final grpcError =
              e is GrpcError ? e : GrpcError.unknown(e.toString());
          _talker.logCustom(
            GrpcErrorLog.unary(
              method: method,
              request: request,
              options: options,
              grpcError: grpcError,
              durationMs: DateTime.now().difference(startTime).inMilliseconds,
              settings: settings,
            ),
          );
        },
      ),
    );

    return response;
  }

  /// {@template talker_grpc_logger_intercept_streaming}
  /// Intercepts a streaming call (client-, server-, or bidi-streaming).
  ///
  /// Emits a lifecycle-oriented sequence:
  /// - `Stream started` at start, when
  ///   [TalkerGrpcLoggerSettings.printStreamInit] is `true`. The marker is
  ///   emitted synchronously before [invoker] runs, so it fires even for
  ///   streams that fail immediately — it marks the start of interception,
  ///   not a successful connection;
  /// - one request entry per outgoing chunk and one response entry per
  ///   incoming chunk, when [TalkerGrpcLoggerSettings.printStreamChunks]
  ///   is `true`;
  /// - `Stream completed (N responses / M requests)` on clean finish, when
  ///   [TalkerGrpcLoggerSettings.printStreamComplete] is `true`. Counters that
  ///   are zero are omitted; if both are zero, the label degrades to
  ///   `Stream completed`;
  /// - a single error entry on failure — completion is suppressed in that
  ///   case so logs never claim a broken stream finished.
  ///
  /// Lifecycle markers (`Stream started`, `Stream completed`) are
  /// emitted as [GrpcEventLog] under [TalkerKey.grpcEvent], so they never
  /// share an entry with a payload-bearing chunk.
  ///
  /// Skipped entirely when [TalkerGrpcLoggerSettings.enabled] is `false`,
  /// in which case the original [ResponseStream] from [invoker] is returned
  /// unchanged (identity — no wrapper is created).
  ///
  /// ```dart
  /// TalkerGrpcLogger(
  ///   settings: const TalkerGrpcLoggerSettings(
  ///     printStreamInit: true,
  ///     printStreamChunks: false, // suppress per-chunk noise
  ///     printStreamComplete: true,
  ///   ),
  /// );
  /// ```
  /// {@endtemplate}
  ///
  /// {@macro talker_grpc_logger_intercept_streaming}
  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    if (!settings.enabled) {
      return invoker(method, requests, options);
    }

    if (settings.printStreamInit) {
      _talker.logCustom(
        GrpcEventLog.stream(
          event: 'Stream started',
          method: method,
          options: options,
          settings: settings,
        ),
      );
    }

    var requestCount = 0;

    final interceptedRequests = requests.map((request) {
      requestCount++;
      if (settings.printStreamChunks) {
        _talker.logCustom(
          GrpcRequestLog.stream(
            method: method,
            request: request,
            options: options,
            settings: settings,
          ),
        );
      }
      return request;
    });

    final responseStream = invoker(method, interceptedRequests, options);

    var chunkCount = 0;
    var terminated = false;

    return InterceptedResponseStream<R>(
      responseStream,
      onResponse: (responseMessage) {
        chunkCount++;
        if (!settings.printStreamChunks) return;
        _talker.logCustom(
          GrpcResponseLog.stream(
            method: method,
            response: responseMessage,
            options: options,
            settings: settings,
          ),
        );
      },
      onError: (error) {
        terminated = true;
        final grpcError =
            error is GrpcError ? error : GrpcError.unknown(error.toString());
        _talker.logCustom(
          GrpcErrorLog.stream(
            method: method,
            options: options,
            grpcError: grpcError,
            settings: settings,
          ),
        );
      },
      onComplete: () {
        if (terminated || !settings.printStreamComplete) return;
        final event = _buildStreamCompleteEventMessage(
          chunkCount: chunkCount,
          requestCount: requestCount,
        );
        _talker.logCustom(
          GrpcEventLog.stream(
            method: method,
            options: options,
            event: event,
            settings: settings,
          ),
        );
      },
    );
  }

  String _buildStreamCompleteEventMessage({
    required int chunkCount,
    required int requestCount,
  }) {
    final parts = <String>[
      if (chunkCount > 0)
        '$chunkCount ${chunkCount == 1 ? 'response' : 'responses'}',
      if (requestCount > 0)
        '$requestCount ${requestCount == 1 ? 'request' : 'requests'}',
    ];
    if (parts.isEmpty) return 'Stream completed';
    return 'Stream completed (${parts.join(' / ')})';
  }
}
