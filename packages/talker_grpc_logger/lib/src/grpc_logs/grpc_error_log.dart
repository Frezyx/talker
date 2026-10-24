import 'package:grpc/grpc.dart';
import 'package:talker/talker.dart';

import '../enums/enums.dart';
import '../talker_grpc_logger_settings.dart';
import 'grpc_log_base.dart';

/// {@template grpc_error_log}
/// A [TalkerLog] representing a failed gRPC call.
///
/// Emitted for both call shapes:
/// - **unary** — a single entry with the request payload (if enabled),
///   elapsed duration, gRPC status code, and error message;
/// - **streaming** — a single terminal entry per failure, regardless of
///   how many chunks were already exchanged.
///
/// Unlike [GrpcEventLog], an error entry never carries an `Event:` line
/// — the failure itself is the terminal event, so a lifecycle marker
/// would be redundant. The request payload is likewise optional: for
/// streaming failures it is generally not available at the point of
/// failure.
///
/// Sections rendered into the entry are controlled by
/// [TalkerGrpcLoggerSettings.printErrorCode],
/// [TalkerGrpcLoggerSettings.printErrorMessage],
/// [TalkerGrpcLoggerSettings.printErrorHeaders],
/// [TalkerGrpcLoggerSettings.printResponseData], and
/// [TalkerGrpcLoggerSettings.hiddenHeaders]; the layout itself is
/// documented in [GrpcLogBase].
///
/// Always emitted with [LogLevel.error], regardless of
/// [TalkerGrpcLoggerSettings.logLevel] — failures must not be silenced
/// by a relaxed log level.
///
/// See also:
/// - [GrpcRequestLog] — outgoing requests;
/// - [GrpcResponseLog] — successful responses;
/// - [GrpcEventLog] — streaming lifecycle markers.
/// {@endtemplate}
class GrpcErrorLog<Q, R> extends GrpcLogBase<Q, R> {
  /// {@macro grpc_error_log}
  GrpcErrorLog._(
    super.message, {
    super.durationMs,
    required super.method,
    required super.options,
    required this.grpcError,
    this.request,
    required super.grpcCallType,
    this.settings = const TalkerGrpcLoggerSettings(),
  }) : super(
          payload: request,
          jsonFormatter: settings.jsonFormatter,
          showData: settings.printResponseData,
          showHeaders: settings.printErrorHeaders,
          showDuration: settings.printResponseDuration,
          hiddenHeaders: settings.hiddenHeaders,
        );

  /// {@template grpc_error_log_unary}
  /// Error log for a unary call. [durationMs] is the elapsed time
  /// between dispatch and failure, as measured by [TalkerGrpcLogger].
  /// {@endtemplate}
  factory GrpcErrorLog.unary({
    required Q request,
    required ClientMethod<Q, R> method,
    required CallOptions options,
    required int durationMs,
    required GrpcError grpcError,
    TalkerGrpcLoggerSettings settings = const TalkerGrpcLoggerSettings(),
  }) =>
      GrpcErrorLog._(
        null,
        grpcCallType: GrpcCallType.unary,
        durationMs: durationMs,
        method: method,
        options: options,
        request: request,
        grpcError: grpcError,
        settings: settings,
      );

  /// {@template grpc_error_log_stream}
  /// Error log for a streaming call.
  ///
  /// A single stream failure produces exactly one entry of this shape —
  /// per-chunk error entries are not emitted. The [request] payload is
  /// generally not available at the point of failure and may be omitted.
  ///
  /// This factory does **not** accept an `event` marker: an error entry
  /// is terminal by definition and never renders an `Event:` line.
  /// {@endtemplate}
  factory GrpcErrorLog.stream({
    Q? request,
    required ClientMethod<Q, R> method,
    required CallOptions options,
    required GrpcError grpcError,
    TalkerGrpcLoggerSettings settings = const TalkerGrpcLoggerSettings(),
  }) =>
      GrpcErrorLog._(
        null,
        grpcCallType: GrpcCallType.stream,
        method: method,
        options: options,
        request: request,
        grpcError: grpcError,
        settings: settings,
      );

  /// The request that triggered the error, or `null` when unknown (the
  /// common case for streaming failures).
  final Q? request;

  /// The caught [GrpcError]. Provides both the status code and the
  /// human-readable message.
  final GrpcError grpcError;

  /// Settings used to build this entry.
  final TalkerGrpcLoggerSettings settings;

  @override
  AnsiPen get pen => settings.errorPen ?? (AnsiPen()..red());

  @override
  String get key => TalkerKey.grpcError;

  @override
  LogLevel? get logLevel => LogLevel.error;

  /// Builds the `Code:` line, or `null` when code rendering is disabled.
  String? buildErrorCode() {
    if (!settings.printErrorCode) return null;
    return 'Code: ${grpcError.codeName}';
  }

  /// Builds the `Message:` line, or `null` when message rendering is
  /// disabled.
  String? buildErrorMessage() {
    if (!settings.printErrorMessage) return null;
    return 'Message: ${grpcError.message}';
  }

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sections = <String?>[
      buildGrpcLogTitle(timeFormat: timeFormat),
      buildDuration(),
      buildHeaders(),
      buildErrorCode(),
      buildErrorMessage(),
    ];

    return sections.whereType<String>().join('\n').trim();
  }
}
