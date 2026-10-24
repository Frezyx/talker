/// {@template grpc_type}
/// The shape of a gRPC call, as far as logging is concerned.
///
/// Used by [GrpcLogBase] to render the bracketed marker in a log entry's
/// title — `[UNARY]` or `[STREAM]` — so a reader can tell at a glance
/// whether the entry belongs to a unary call or a streaming one.
///
/// Both unary and streaming calls share the same set of [TalkerKey]s
/// (`grpcRequest`, `grpcResponse`, `grpcError`), so this type is the only
/// signal in the entry itself that distinguishes them. Consumers that
/// need to filter or group by call shape should read [GrpcLogBase.grpcCallType]
/// on the log object rather than parse the rendered title.
///
/// ```dart
/// final log = GrpcRequestLog<String, String>.unary(...);
/// assert(log.grpcCallType == GrpcCallType.unary);
/// ```
/// {@endtemplate}
enum GrpcCallType {
  /// A unary call: exactly one request in, exactly one response out.
  ///
  /// Rendered with the `[UNARY]` prefix. Produces exactly one request log
  /// and one terminal entry — either a response log on success or an
  /// error log on failure.
  unary,

  /// A streaming call: client-streaming, server-streaming, or bidi.
  ///
  /// Rendered with the `[STREAM]` prefix. Produces a lifecycle-oriented
  /// sequence of entries — an optional `Stream started` marker, zero
  /// or more per-chunk request/response entries, and either a
  /// `Stream completed (N chunks)` marker or a single terminal error
  /// entry. Which of these are emitted is controlled by the
  /// `printStream*` flags on [TalkerGrpcLoggerSettings].
  stream,
}
