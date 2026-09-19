import 'package:grpc/grpc.dart';
import 'package:talker/talker.dart';

import '../enums/enums.dart';
import '../talker_grpc_logger_settings.dart';
import 'grpc_log_base.dart';

/// {@template grpc_request_log}
/// A [TalkerLog] representing a single outgoing gRPC request entry.
///
/// Emitted for both call shapes:
/// - **unary** — one entry per call, produced before the request is
///   dispatched;
/// - **streaming** — one entry per outgoing chunk, carrying that chunk's
///   payload.
///
/// Lifecycle markers (`Stream started` and friends) do not go through
/// this class — they are emitted as [GrpcEventLog], which carries an
/// `Event:` line instead of a `Data:` payload.
///
/// Sections rendered into the entry are controlled by
/// [TalkerGrpcLoggerSettings.printRequestData],
/// [TalkerGrpcLoggerSettings.printRequestHeaders], and
/// [TalkerGrpcLoggerSettings.hiddenHeaders]; the layout itself is
/// documented in [GrpcLogBase].
///
/// See also:
/// - [GrpcResponseLog] — incoming responses and response chunks;
/// - [GrpcErrorLog] — terminal failures;
/// - [GrpcEventLog] — streaming lifecycle markers;
/// - [TalkerGrpcLogger] — the interceptor that produces these entries.
/// {@endtemplate}
class GrpcRequestLog<Q, R> extends GrpcLogBase<Q, R> {
  /// {@macro grpc_request_log}
  GrpcRequestLog._(
    super.message, {
    required super.method,
    required super.options,
    required super.grpcCallType,
    required this.request,
    this.settings = const TalkerGrpcLoggerSettings(),
  }) : super(
          payload: request,
          jsonFormatter: settings.jsonFormatter,
          showData: settings.printRequestData,
          showHeaders: settings.printRequestHeaders,
          hiddenHeaders: settings.hiddenHeaders,
          showDuration: false,
        );

  /// {@template grpc_request_log_unary}
  /// Request log for a unary call. Always carries a payload — the
  /// request the caller just sent.
  /// {@endtemplate}
  factory GrpcRequestLog.unary({
    required Q request,
    required ClientMethod<Q, R> method,
    required CallOptions options,
    TalkerGrpcLoggerSettings settings = const TalkerGrpcLoggerSettings(),
  }) =>
      GrpcRequestLog._(
        null,
        grpcCallType: GrpcCallType.unary,
        method: method,
        options: options,
        request: request,
        settings: settings,
      );

  /// {@template grpc_request_log_stream}
  /// Request log for a per-chunk entry of a streaming call. Carries the
  /// outgoing payload, rendered as `Data:`.
  /// {@endtemplate}
  factory GrpcRequestLog.stream({
    required Q request,
    required ClientMethod<Q, R> method,
    required CallOptions options,
    TalkerGrpcLoggerSettings settings = const TalkerGrpcLoggerSettings(),
  }) =>
      GrpcRequestLog._(
        null,
        grpcCallType: GrpcCallType.stream,
        method: method,
        options: options,
        request: request,
        settings: settings,
      );

  /// The request payload. Always non-null: this entry type exists only
  /// to render payloads.
  final Q request;

  /// Settings used to build this entry.
  final TalkerGrpcLoggerSettings settings;

  @override
  AnsiPen get pen => settings.requestPen ?? (AnsiPen()..xterm(219));

  @override
  String get key => TalkerKey.grpcRequest;

  @override
  LogLevel? get logLevel => settings.logLevel;
}
