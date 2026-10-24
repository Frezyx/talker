import 'package:equatable/equatable.dart';
import 'package:talker/talker.dart';

/// {@template talker_grpc_logger_settings}
/// Configuration for [TalkerGrpcLogger].
///
/// Every field is a plain value (no side effects), so instances are cheap to
/// create and safe to share between isolates. The class is [Equatable], so
/// two settings with identical values compare equal — handy for tests and
/// for caching.
///
/// Typical usage:
/// ```dart
/// TalkerGrpcLogger(
///   settings: const TalkerGrpcLoggerSettings(
///     logLevel: LogLevel.info,
///     hiddenHeaders: {'authorization', 'x-api-key'},
///     printStreamChunks: false,
///   ),
/// );
/// ```
///
/// Use [copyWith] to derive a new instance without repeating every field:
/// ```dart
/// final debugSettings = base.copyWith(logLevel: LogLevel.debug);
/// ```
/// {@endtemplate}
class TalkerGrpcLoggerSettings with Equatable {
  /// {@macro talker_grpc_logger_settings}
  const TalkerGrpcLoggerSettings({
    this.enabled = true,
    this.logLevel = LogLevel.debug,
    this.printRequestData = true,
    this.printRequestHeaders = true,
    this.printResponseData = true,
    this.printResponseHeaders = true,
    this.printResponseDuration = true,
    this.printErrorCode = true,
    this.printErrorHeaders = true,
    this.printErrorMessage = true,
    this.printStreamInit = true,
    this.printStreamChunks = true,
    this.printStreamComplete = true,
    this.hiddenHeaders = const <String>{},
    this.jsonFormatter = const TalkerJsonFormatter(),
    this.requestPen,
    this.responsePen,
    this.errorPen,
  });

  /// {@template talker_grpc_logger_settings_enabled}
  /// Master switch. When `false`, [TalkerGrpcLogger] passes the call through
  /// untouched: no interception, no logs, no measurable overhead.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool enabled;

  /// {@template talker_grpc_logger_settings_log_level}
  /// [LogLevel] attached to request and response logs emitted by
  /// [TalkerGrpcLogger]. Error logs always use [LogLevel.error] regardless
  /// of this value.
  ///
  /// Defaults to [LogLevel.debug].
  /// {@endtemplate}
  final LogLevel logLevel;

  /// {@template talker_grpc_logger_settings_print_request_data}
  /// Whether to render the request payload inside request logs
  /// (`Data: {...}` block). When `false`, the log entry is still emitted,
  /// but the payload is omitted.
  ///
  /// Useful for filtering out bulky payloads while keeping the request
  /// timing and headers visible.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool printRequestData;

  /// {@template talker_grpc_logger_settings_print_request_headers}
  /// Whether to render the gRPC metadata (headers) in request logs.
  ///
  /// Combined with [hiddenHeaders] this lets you keep diagnostic headers
  /// (`x-trace-id`, `x-correlation-id`) while masking secrets.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool printRequestHeaders;

  /// {@template talker_grpc_logger_settings_print_response_data}
  /// Whether to render the response payload inside response logs.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool printResponseData;

  /// {@template talker_grpc_logger_settings_print_response_headers}
  /// Whether to render the gRPC metadata (headers) in response logs.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool printResponseHeaders;

  /// {@template talker_grpc_logger_settings_print_response_duration}
  /// Whether to render the elapsed time (in milliseconds) for a completed
  /// request.
  ///
  /// Disable if your log aggregator already computes timings from
  /// timestamps and you want to reduce noise.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool printResponseDuration;

  /// {@template talker_grpc_logger_settings_print_error_code}
  /// Whether to render `Code: <GRPC_STATUS>` (e.g. `UNAVAILABLE`,
  /// `PERMISSION_DENIED`) in error logs.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool printErrorCode;

  /// {@template talker_grpc_logger_settings_print_error_headers}
  /// Whether to render request metadata in error logs. Uses the same
  /// obfuscation rules as [printRequestHeaders] and [hiddenHeaders].
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool printErrorHeaders;

  /// {@template talker_grpc_logger_settings_print_error_message}
  /// Whether to render `Message: <text>` in error logs.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool printErrorMessage;

  /// {@template talker_grpc_logger_settings_print_stream_init}
  /// Emit a lifecycle entry (`Stream started`) when a streaming call
  /// starts.
  ///
  /// Disable for long-lived or high-frequency streams where the init entry
  /// adds noise without actionable information.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool printStreamInit;

  /// {@template talker_grpc_logger_settings_print_stream_chunks}
  /// Emit a log entry per individual chunk flowing through a stream
  /// (both outgoing requests and incoming responses).
  ///
  /// When `false`, only lifecycle entries — init, completion, error —
  /// are emitted. This is orthogonal to [printRequestData] and
  /// [printResponseData]: those control the *content* of a chunk entry,
  /// this flag controls whether a chunk entry is created at all.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool printStreamChunks;

  /// {@template talker_grpc_logger_settings_print_stream_done}
  /// Emit a lifecycle entry (`Stream completed (N responses / M requests)`)
  /// when a streaming call finishes successfully.
  ///
  /// The counters reflect the number of incoming response chunks and
  /// outgoing request chunks respectively. A zero counter is omitted; when
  /// both are zero the label degrades to a bare `Stream completed`.
  ///
  /// The entry is suppressed if the stream terminated with an error;
  /// in that case only the error entry is emitted.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool printStreamComplete;

  /// {@template talker_grpc_logger_settings_pens}
  /// Optional [AnsiPen] overrides for console coloring.
  ///
  /// Any pen left `null` falls back to the default palette:
  /// - requests — violet (`xterm(219)`)
  /// - responses — green (`xterm(46)`)
  /// - errors — red
  ///
  /// Example:
  /// ```dart
  /// TalkerGrpcLoggerSettings(
  ///   requestPen: AnsiPen()..blue(),
  ///   errorPen: AnsiPen()..magenta(),
  /// );
  /// ```
  /// See [AnsiPen] for supported colors and modifiers.
  /// {@endtemplate}
  final AnsiPen? requestPen;

  /// {@macro talker_grpc_logger_settings_pens}
  final AnsiPen? responsePen;

  /// {@macro talker_grpc_logger_settings_pens}
  final AnsiPen? errorPen;

  /// {@template talker_grpc_logger_settings_hidden_headers}
  /// Header names whose values are replaced with `*****` in log output.
  ///
  /// Matching is **case-insensitive**: `{'authorization'}` masks
  /// `Authorization`, `AUTHORIZATION`, and `authorization`.
  ///
  /// The original `CallOptions.metadata` is never mutated — obfuscation
  /// happens on a copy used only for formatting.
  ///
  /// Example:
  /// ```dart
  /// const TalkerGrpcLoggerSettings(
  ///   hiddenHeaders: {'authorization', 'cookie', 'x-api-key'},
  /// );
  /// ```
  ///
  /// Defaults to an empty set (no masking).
  /// {@endtemplate}
  final Set<String> hiddenHeaders;

  /// {@template talker_grpc_logger_settings_json_formatter}
  /// Formatter used to render payloads and headers.
  ///
  /// Options:
  /// - [TalkerJsonFormatter] — default, pretty-printed JSON with quotes.
  /// - `TalkerJsonFormatter(stripQuotes: true)` — removes surrounding
  ///   quotes from scalar values.
  /// - `TalkerJsonFormatter.custom(fn)` — full control over the output.
  ///
  /// Defaults to `const TalkerJsonFormatter()`.
  /// {@endtemplate}
  final TalkerJsonFormatter jsonFormatter;

  /// {@template talker_grpc_logger_settings_copy_with}
  /// Creates a copy of this settings object with the given fields replaced.
  ///
  /// Omitted arguments keep their current value. To intentionally set a
  /// field to `null` (only applicable to the pen fields), pass the sentinel
  /// via [copyWith] — the nullable parameters distinguish “not provided”
  /// from “provided as null” through the `?? this.x` pattern, so passing
  /// an explicit `null` is not supported here. Clear pens by constructing
  /// a fresh instance instead.
  /// {@endtemplate}
  TalkerGrpcLoggerSettings copyWith({
    bool? enabled,
    LogLevel? logLevel,
    bool? printResponseData,
    bool? printResponseHeaders,
    bool? printResponseDuration,
    bool? printErrorCode,
    bool? printErrorHeaders,
    bool? printErrorMessage,
    bool? printRequestData,
    bool? printRequestHeaders,
    bool? printStreamInit,
    bool? printStreamChunks,
    bool? printStreamComplete,
    AnsiPen? requestPen,
    AnsiPen? responsePen,
    AnsiPen? errorPen,
    Set<String>? hiddenHeaders,
    TalkerJsonFormatter? jsonFormatter,
  }) =>
      TalkerGrpcLoggerSettings(
        enabled: enabled ?? this.enabled,
        logLevel: logLevel ?? this.logLevel,
        printResponseData: printResponseData ?? this.printResponseData,
        printResponseHeaders: printResponseHeaders ?? this.printResponseHeaders,
        printResponseDuration:
            printResponseDuration ?? this.printResponseDuration,
        printErrorCode: printErrorCode ?? this.printErrorCode,
        printErrorHeaders: printErrorHeaders ?? this.printErrorHeaders,
        printErrorMessage: printErrorMessage ?? this.printErrorMessage,
        printRequestData: printRequestData ?? this.printRequestData,
        printRequestHeaders: printRequestHeaders ?? this.printRequestHeaders,
        printStreamInit: printStreamInit ?? this.printStreamInit,
        printStreamChunks: printStreamChunks ?? this.printStreamChunks,
        printStreamComplete: printStreamComplete ?? this.printStreamComplete,
        requestPen: requestPen ?? this.requestPen,
        responsePen: responsePen ?? this.responsePen,
        errorPen: errorPen ?? this.errorPen,
        hiddenHeaders: hiddenHeaders ?? this.hiddenHeaders,
        jsonFormatter: jsonFormatter ?? this.jsonFormatter,
      );

  @override
  List<Object?> get props => [
        enabled,
        logLevel,
        printResponseData,
        printResponseHeaders,
        printResponseDuration,
        printErrorCode,
        printErrorHeaders,
        printErrorMessage,
        printRequestData,
        printRequestHeaders,
        printStreamInit,
        printStreamChunks,
        printStreamComplete,
        requestPen,
        responsePen,
        errorPen,
        hiddenHeaders,
        jsonFormatter,
      ];
}
