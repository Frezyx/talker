import 'package:talker/talker.dart';

/// Base implementation of [TalkerDataInterface]
/// to create Logs
class TalkerLog implements TalkerDataInterface {
  TalkerLog(
    this.message, {
    this.logLevel,
    this.exception,
    this.error,
    this.stackTrace,
    this.additional,
    this.title,
    DateTime? time,
    this.pen,
  }) {
    _time = time ?? DateTime.now();
  }

  late DateTime _time;

  /// {@macro talker_data_message}
  @override
  final String message;

  @override
  final Exception? exception;

  /// {@macro talker_data_error}
  @override
  final Error? error;

  /// {@macro talker_data_stackTrace}
  @override
  final StackTrace? stackTrace;

  /// {@macro talker_data_title}
  @override
  final String? title;

  /// {@macro talker_data_additional}
  @override
  final Map<String, dynamic>? additional;

  /// {@macro talker_data_loglevel}
  @override
  final LogLevel? logLevel;

  /// {@macro talker_data_generateTextMessage}
  @override
  String generateTextMessage() {
    return '$displayTitle$message$displayAditional';
  }

  /// {@macro talker_data_time}
  @override
  DateTime get time => _time;

  /// [AnsiPen?] [pen] - sets your own log color for console
  final AnsiPen? pen;
}
