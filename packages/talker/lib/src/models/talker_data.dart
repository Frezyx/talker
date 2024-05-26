import 'package:talker/src/utils/time_format.dart';
import 'package:talker/talker.dart';

/// Base [Talker] Data transfer object
/// Objects of this type are passed through
/// handlers observer and stream
class TalkerData {
  TalkerData(
    this.message, {
    this.logLevel,
    this.exception,
    this.error,
    this.stackTrace,
    this.title = 'log',
    DateTime? time,
    this.pen,
    this.key,
  }) {
    _time = time ?? DateTime.now();
  }

  late DateTime _time;

  /// {@template talker_data_message}
  /// [String] [message] - message describes what happened
  /// {@endtemplate}
  final String? message;

  final String? key;

  /// {@template talker_data_loglevel}
  /// [LogLevel] [logLevel] - to control logging output
  /// {@endtemplate}
  final LogLevel? logLevel;

  /// {@template talker_data_exception}
  /// [Exception?] [exception] - exception if it happened
  /// {@endtemplate}
  final Object? exception;

  /// {@template talker_data_error}
  /// [Error?] [error] - error if it happened
  /// {@endtemplate}
  final Error? error;

  /// {@template talker_data_title}
  /// Title of Talker log
  /// {@endtemplate}
  String? title;

  /// {@template talker_data_stackTrace}
  /// StackTrace?] [stackTrace] - stackTrace if [exception] or [error] happened
  /// {@endtemplate}
  final StackTrace? stackTrace;

  /// {@template talker_data_time}
  /// Internal time when the log occurred
  /// {@endtemplate}
  DateTime get time => _time;

  /// [AnsiPen?] [pen] - sets your own log color for console
  final AnsiPen? pen;

  /// {@template talker_data_generateTextMessage}
  /// Internal method that generates
  /// a complete message about the event
  ///
  /// See examples:
  /// [TalkerLog] -> [TalkerLog.generateTextMessage]
  /// [TalkerException] -> [TalkerException.generateTextMessage]
  /// [TalkerError] -> [TalkerError.generateTextMessage]
  ///
  /// {@endtemplate}
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return '${displayTitleWithTime(timeFormat: timeFormat)}$message$displayStackTrace';
  }
}

/// Extension to get
/// display text of [TalkerData] fields
extension FieldsToDisplay on TalkerData {
  /// Displayed title of [TalkerData]

  String displayTitleWithTime(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return '[$title] | $displayTime | ';
  }

  /// Displayed stackTrace of [TalkerData]
  String get displayStackTrace {
    if (stackTrace == null || stackTrace == StackTrace.empty) {
      return '';
    }
    return '\nStackTrace: $stackTrace}';
  }

  /// Displayed exception of [TalkerData]
  String get displayException {
    if (exception == null) {
      return '';
    }
    return '\n$exception';
  }

  /// Displayed error of [TalkerData]
  String get displayError {
    if (error == null) {
      return '';
    }
    return '\n$error';
  }

  /// Displayed message of [TalkerData]
  String get displayMessage {
    if (message == null) {
      return '';
    }
    return '$message';
  }

  /// Displayed tile of [TalkerData]
  String displayTime({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) =>
      TalkerDateTimeFormatter(time, timeFormat: timeFormat).format;
}
