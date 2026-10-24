import 'package:grpc/grpc.dart';
import 'package:talker/talker.dart';

import '../enums/enums.dart';
import '../talker_grpc_logger_settings.dart';
import 'grpc_log_base.dart';

/// {@template grpc_response_log}
/// A [TalkerLog] representing a successful gRPC response entry.
///
/// Emitted for both call shapes:
/// - **unary** — one entry per call, carrying the response payload and
///   the elapsed time between dispatch and completion;
/// - **streaming** — one entry per incoming chunk, carrying that chunk's
///   payload.
///
/// Lifecycle markers (`Stream completed (N responses / M requests)` and
/// friends) do not go through this class — they are emitted as
/// [GrpcEventLog], which carries an `Event:` line instead of a `Data:`
/// payload.
///
/// A stream that fails never produces a completion entry — a
/// [GrpcErrorLog] is emitted instead, so a broken stream is never
/// reported as finished.
///
/// Sections rendered into the entry are controlled by
/// [TalkerGrpcLoggerSettings.printResponseData],
/// [TalkerGrpcLoggerSettings.printResponseHeaders],
/// [TalkerGrpcLoggerSettings.printResponseDuration], and
/// [TalkerGrpcLoggerSettings.hiddenHeaders]; the layout itself is
/// documented in [GrpcLogBase].
///
/// See also:
/// - [GrpcRequestLog] — outgoing requests and request chunks;
/// - [GrpcErrorLog] — terminal failures;
/// - [GrpcEventLog] — streaming lifecycle markers.
/// {@endtemplate}
class GrpcResponseLog<Q, R> extends GrpcLogBase<Q, R> {
  /// {@macro grpc_response_log}
  GrpcResponseLog._(
    super.message, {
    super.durationMs,
    required super.method,
    required super.options,
    required super.grpcCallType,
    required this.response,
    this.settings = const TalkerGrpcLoggerSettings(),
  }) : super(
          payload: response,
          jsonFormatter: settings.jsonFormatter,
          showData: settings.printResponseData,
          showHeaders: settings.printResponseHeaders,
          showDuration: settings.printResponseDuration,
          hiddenHeaders: settings.hiddenHeaders,
        );

  /// {@template grpc_response_log_unary}
  /// Response log for a unary call. Always carries a payload and a
  /// non-negative [durationMs] — the elapsed time between dispatch and
  /// completion, as measured by [TalkerGrpcLogger].
  /// {@endtemplate}
  factory GrpcResponseLog.unary({
    required R response,
    required ClientMethod<Q, R> method,
    required CallOptions options,
    required int durationMs,
    TalkerGrpcLoggerSettings settings = const TalkerGrpcLoggerSettings(),
  }) =>
      GrpcResponseLog._(
        null,
        durationMs: durationMs,
        method: method,
        options: options,
        response: response,
        grpcCallType: GrpcCallType.unary,
        settings: settings,
      );

  /// {@template grpc_response_log_stream}
  /// Response log for a per-chunk entry of a streaming call. Carries the
  /// incoming payload, rendered as `Data:`, and no duration — individual
  /// chunks have no meaningful elapsed time.
  /// {@endtemplate}
  factory GrpcResponseLog.stream({
    required R response,
    required ClientMethod<Q, R> method,
    required CallOptions options,
    TalkerGrpcLoggerSettings settings = const TalkerGrpcLoggerSettings(),
  }) =>
      GrpcResponseLog._(
        null,
        method: method,
        options: options,
        response: response,
        grpcCallType: GrpcCallType.stream,
        settings: settings,
      );

  /// The response payload. Always non-null: this entry type exists only
  /// to render payloads.
  final R response;

  /// Settings used to build this entry.
  final TalkerGrpcLoggerSettings settings;

  @override
  AnsiPen get pen => settings.responsePen ?? (AnsiPen()..xterm(46));

  @override
  String get key => TalkerKey.grpcResponse;

  @override
  LogLevel? get logLevel => settings.logLevel;
}
