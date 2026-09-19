import 'package:grpc/grpc.dart';
import 'package:protobuf/protobuf.dart' show GeneratedMessage;
import 'package:talker/talker.dart';

import '../enums/enums.dart';

/// {@template grpc_log_base}
/// Shared rendering and formatting for every gRPC log entry emitted by
/// [TalkerGrpcLogger].
///
/// Concrete subclasses ([GrpcRequestLog], [GrpcResponseLog],
/// [GrpcErrorLog], [GrpcEventLog]) supply the fields; this base decides
/// how they are laid out in the rendered message:
///
/// ```text
/// [<key>] | <time> | [<UNARY|STREAM>] <method.path>
/// Duration: <n> ms       // when showDuration && durationMs is non-negative
/// Headers: {...}         // when showHeaders && metadata is not empty
/// Data: {...}            // when showData && payload != null
/// ```
///
/// The layout is deliberately flat — one section per line — so both the
/// console view and any external log parser can rely on stable prefixes.
///
/// ### Rendering rules
///
/// - `Duration:` is skipped when [durationMs] is `null` or negative, and
///   when [showDuration] is `false`. `0 ms` is a valid, printed value.
/// - Header obfuscation via [hiddenHeaders] is applied to a copy; the
///   original `CallOptions.metadata` is never mutated.
/// {@endtemplate}
abstract class GrpcLogBase<Q, R> extends TalkerLog {
  /// {@macro grpc_log_base}
  GrpcLogBase(
    super.message, {
    required this.method,
    required this.options,
    required this.grpcCallType,
    required this.payload,
    required this.jsonFormatter,
    required this.showData,
    required this.showHeaders,
    required this.showDuration,
    this.durationMs,
    this.hiddenHeaders = const <String>{},
  });

  /// Elapsed time in milliseconds, or `null` when the entry has no
  /// meaningful duration yet (e.g. a streaming chunk).
  ///
  /// A negative value is treated the same as `null`: the `Duration:`
  /// line is not rendered. Non-negative values, including `0`, are.
  final int? durationMs;

  /// The gRPC method this entry belongs to. Only [ClientMethod.path] is
  /// used in the rendered title.
  final ClientMethod<Q, R> method;

  /// Call options of the original call. Used for metadata rendering and
  /// for header obfuscation.
  final CallOptions options;

  /// Call shape; drives the `[UNARY]` / `[STREAM]` marker in the title.
  final GrpcCallType grpcCallType;

  /// Payload to render under `Data:`, or `null` when the entry is a
  /// lifecycle marker rather than a payload-bearing record.
  final Object? payload;

  /// Formatter applied to both [payload] and the metadata map.
  final TalkerJsonFormatter jsonFormatter;

  /// Whether `Data:` is rendered.
  final bool showData;

  /// Whether `Headers:` is rendered.
  final bool showHeaders;

  /// Whether `Duration:` is rendered (provided [durationMs] is
  /// non-negative).
  final bool showDuration;

  /// Case-insensitive set of header names whose values are replaced with
  /// `*****` in the rendered output. Matching is done on a copy; the
  /// original `options.metadata` is never mutated.
  final Set<String> hiddenHeaders;

  /// Builds the first line of the rendered message:
  /// `[<key>] | <time> | [<UNARY|STREAM>] <method.path>`.
  String buildGrpcLogTitle({
    required TimeFormat timeFormat,
  }) {
    final time = TalkerDateTimeFormatter(
      DateTime.now(),
      timeFormat: timeFormat,
    ).timeAndSeconds;

    return [
      '[$key]',
      time,
      '[${grpcCallType.name.toUpperCase()}] ${method.path}',
    ].join(' | ');
  }

  /// Builds the `Duration:` line, or `null` when it should not be
  /// rendered — see [durationMs] and [showDuration].
  String? buildDuration() {
    if (durationMs case final ms? when showDuration && !ms.isNegative) {
      return 'Duration: $durationMs ms';
    }
    return null;
  }

  /// Builds the `Headers:` line, or `null` when headers are disabled or
  /// metadata is empty.
  String? buildHeaders() {
    if (!showHeaders) return null;
    final headers = replaceHiddenHeaders(options.metadata);
    if (headers.isEmpty) return null;
    return 'Headers: ${jsonFormatter.format(headers)}';
  }

  /// Builds the `Data:` line, or `null` when payload rendering is
  /// disabled or the entry carries no payload.
  ///
  /// [GeneratedMessage] instances are converted to their proto3 JSON
  /// representation first, so the output matches the wire contract
  /// rather than the (often noisy) `toString()`. Any failure inside the
  /// formatter or the conversion falls back to [Object.toString] so a
  /// single bad payload never breaks the whole log entry.
  String? buildPayload() {
    if (!showData) return null;
    final value = payload;
    if (value == null) return null;

    try {
      final formatted = value is GeneratedMessage
          ? jsonFormatter.format(value.toProto3Json())
          : jsonFormatter.format(value);
      return 'Data: $formatted';
    } catch (_) {
      return 'Data: $value';
    }
  }

  /// Returns a copy of [headers] with hidden values replaced by `*****`.
  ///
  /// Matching against [hiddenHeaders] is case-insensitive. When
  /// [hiddenHeaders] is empty the input map is copied verbatim; the
  /// input is never mutated either way.
  Map<String, String> replaceHiddenHeaders(Map<String, String> headers) {
    if (hiddenHeaders.isEmpty || headers.isEmpty) {
      return Map<String, String>.of(headers);
    }

    final hidden = hiddenHeaders.map((h) => h.toLowerCase()).toSet();

    return <String, String>{
      for (final e in headers.entries)
        e.key: hidden.contains(e.key.toLowerCase()) ? '*****' : e.value,
    };
  }

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sections = <String?>[
      buildGrpcLogTitle(timeFormat: timeFormat),
      buildDuration(),
      buildHeaders(),
      buildPayload(),
    ];

    return sections.whereType<String>().join('\n').trim();
  }
}
