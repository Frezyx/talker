import 'package:talker/talker.dart';

/// Base [Talker] Data transfer object
/// Objects of this type are passed through
/// handlers observers and stream
abstract class TalkerDataInterface {
  /// [String] [message] - message describes what happened
  String? get message;

  /// [LogLevel] [logLevel] - to control logging output
  LogLevel? get logLevel;

  /// [Exception?] [exception] - exception if it happened
  Exception? get exception;

  /// [Error?] [error] - error if it happened
  Error? get error;

  /// StackTrace?] [stackTrace] - stackTrace if [exception] or [error] happened
  StackTrace? get stackTrace;

  /// [Map<String, dynamic>?] [additional] - additional log data for
  Map<String, dynamic>? get additional;

  /// Internal time when the error occurred
  DateTime get time;

  /// Internal method that generates
  /// a complete message about the event
  ///
  /// See examples:
  /// [TalkerLog] -> [TalkerLog.generateTextMessage]
  /// [TalkerException] -> [TalkerException.generateTextMessage]
  /// [TalkerError] -> [TalkerError.generateTextMessage]
  ///
  String generateTextMessage();
}

/// Extension to get
/// display text of [TalkerDataInterface] fileds
extension FeildsToDisplay on TalkerDataInterface {
  /// Displayed title of [TalkerDataInterface]
  String get displayTitle {
    var title = '';
    switch (runtimeType) {
      case TalkerError:
        title = 'ERROR';
        break;
      case TalkerException:
        title = 'EXCEPTION';
        break;
      case TalkerLog:
      default:
        title = logLevel.title;
        break;
    }
    return '[$title]' + ' | $displayTime | ';
  }

  /// Displayed stackTrace of [TalkerDataInterface]
  String get displayStackTrace {
    if (stackTrace == null) {
      return '';
    }
    return '\n${stackTrace ?? ''}';
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

  /// Displayed additional of [TalkerDataInterface]
  String get displayAditional {
    if (additional == null) {
      return '';
    }
    return '\n$additional';
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
