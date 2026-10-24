import 'package:grpc/grpc.dart';
import 'package:talker/talker.dart';

import '../enums/enums.dart';
import '../talker_grpc_logger_settings.dart';
import 'grpc_log_base.dart';

/// {@template grpc_event_log}
/// A [TalkerLog] representing a lifecycle marker of a streaming call.
///
/// Unlike [GrpcRequestLog] and [GrpcResponseLog], this entry carries no
/// payload and no duration — only an `Event:` line. It is emitted for
/// streaming-only markers such as `Stream started` and
/// `Stream completed (N responses / M requests)`.
///
/// `Event:` never coexists with `Data:`: a log entry is either a
/// payload-bearing chunk or a lifecycle marker, not both.
/// {@endtemplate}
class GrpcEventLog<Q, R> extends GrpcLogBase<Q, R> {
  /// {@macro grpc_event_log}
  GrpcEventLog._(
    super.message, {
    required super.method,
    required super.options,
    required super.grpcCallType,
    required this.event,
    this.settings = const TalkerGrpcLoggerSettings(),
  }) : super(
          payload: null,
          jsonFormatter: settings.jsonFormatter,
          showData: false,
          showHeaders: settings.printRequestHeaders,
          hiddenHeaders: settings.hiddenHeaders,
          showDuration: false,
        );

  /// Creates a lifecycle-marker entry for a streaming call.
  ///
  /// [event] is the human-readable label rendered as `Event: <event>`,
  /// e.g. `Stream started` or `Stream completed (2 responses / 1
  /// request)`.
  factory GrpcEventLog.stream({
    required String event,
    required ClientMethod<Q, R> method,
    required CallOptions options,
    TalkerGrpcLoggerSettings settings = const TalkerGrpcLoggerSettings(),
  }) =>
      GrpcEventLog._(
        null,
        grpcCallType: GrpcCallType.stream,
        method: method,
        options: options,
        event: event,
        settings: settings,
      );

  /// Lifecycle marker rendered as `Event: <event>`.
  final String event;

  /// Settings used to build this entry.
  final TalkerGrpcLoggerSettings settings;

  @override
  AnsiPen get pen => settings.requestPen ?? (AnsiPen()..xterm(219));

  @override
  String get key => 'grpc-event';

  @override
  LogLevel? get logLevel => settings.logLevel;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sections = <String?>[
      buildGrpcLogTitle(timeFormat: timeFormat),
      'Event: $event',
    ];

    return sections.whereType<String>().join('\n').trim();
  }
}
