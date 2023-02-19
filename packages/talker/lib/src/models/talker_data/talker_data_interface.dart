import 'package:talker/talker.dart';

/// Base [Talker] Data transfer object
/// Objects of this type are passed through
/// handlers observers and stream
abstract class TalkerDataInterface {
  /// {@template talker_data_message}
  /// [String] [message] - message describes what happened
  /// {@endtemplate}
  String? get message;

  /// {@template talker_data_loglevel}
  /// [LogLevel] [logLevel] - to control logging output
  /// {@endtemplate}
  LogLevel? get logLevel;

  /// {@template talker_data_exception}
  /// [Exception?] [exception] - exception if it happened
  /// {@endtemplate}
  Exception? get exception;

  /// {@template talker_data_error}
  /// [Error?] [error] - error if it happened
  /// {@endtemplate}
  Error? get error;

  /// {@template talker_data_title}
  /// Title of Talker log
  /// {@endtemplate}
  String? get title;

  /// {@template talker_data_stackTrace}
  /// StackTrace?] [stackTrace] - stackTrace if [exception] or [error] happened
  /// {@endtemplate}
  StackTrace? get stackTrace;

  /// {@template talker_data_time}
  /// Internal time when the error occurred
  /// {@endtemplate}
  DateTime get time;

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
  String generateTextMessage();
}

/// Extension to get
/// display text of [TalkerDataInterface] fileds
extension FeildsToDisplay on TalkerDataInterface {
  /// Displayed title of [TalkerDataInterface]
  String get displayTitle {
    var t = '';
    switch (runtimeType) {
      case TalkerError:
        t = 'ERROR';
        break;
      case TalkerException:
        t = 'EXCEPTION';
        break;
      case TalkerLog:
      default:
        t = title ?? logLevel.title;
        break;
    }
    return t;
  }

  String get displayTitleWithTime {
    return '[$displayTitle] | $displayTime | ';
  }

  /// Displayed stackTrace of [TalkerDataInterface]
  String get displayStackTrace {
    if (stackTrace == null) {
      return '';
    }
    if (stackTrace == StackTrace.empty) {
      return '';
    }
    return '\nStackTrace: $stackTrace}';
  }

  /// Displayed exception of [TalkerDataInterface]
  String get displayException {
    if (exception == null) {
      return '';
    }
    return '\n$exception';
  }

  /// Displayed error of [TalkerDataInterface]
  String get displayError {
    if (error == null) {
      return '';
    }
    return '\n$error';
  }

  /// Displayed message of [TalkerDataInterface]
  String get displayMessage {
    if (message == null) {
      return '';
    }
    return '$message';
  }

  /// Displayed tile of [TalkerDataInterface]
  String get displayTime => TalkerDateTimeFormater(time).timeAndSeconds;
}
