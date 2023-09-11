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
    String? title,
    DateTime? time,
    this.pen,
  }) {
    _title = title ?? logLevel.title;
    _time = time ?? DateTime.now();
  }

  late DateTime _time;
  late String _title;

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
  String get title => _title;

  /// {@macro talker_data_loglevel}
  @override
  final LogLevel? logLevel;

  /// {@macro talker_data_generateTextMessage}
  @override
  String generateTextMessage() {
    return '$displayTitleWithTime$message$displayStackTrace';
  }

  /// {@macro talker_data_time}
  @override
  DateTime get time => _time;

  /// [AnsiPen?] [pen] - sets your own log color for console
  final AnsiPen? pen;
}
