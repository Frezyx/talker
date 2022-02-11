import 'package:talker/talker.dart';

/// Base implementation of [TalkerDataInterface]
/// to handle ONLY [Exceptions]s
class TalkerException implements TalkerDataInterface {
  TalkerException(
    this.exception, {
    this.message,
    this.logLevel,
    this.stackTrace,
    this.title,
    DateTime? time,
  }) {
    _time = time ?? DateTime.now();
  }

  late DateTime _time;

  /// {@macro talker_data_exception}
  @override
  final Exception exception;

  /// {@macro talker_data_message}
  @override
  final String? message;

  /// {@macro talker_data_stackTrace}
  @override
  final StackTrace? stackTrace;

  /// {@macro talker_data_title}
  @override
  final String? title;

  /// {@macro talker_data_loglevel}
  @override
  final LogLevel? logLevel;

  /// {@macro talker_data_generateTextMessage}
  @override
  String generateTextMessage() {
    return '$displayTitleWithTime$displayMessage$displayException$displayStackTrace';
  }

  /// {@macro talker_data_time}
  @override
  DateTime get time => _time;

  /// {@macro talker_data_error}
  /// Not used in [TalkerException]
  @override
  final Error? error = null;
}
