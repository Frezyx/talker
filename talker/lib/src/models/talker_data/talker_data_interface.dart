import 'package:talker/talker.dart';

abstract class TalkerDataInterface {
  String? get message;
  LogLevel? get logLevel;
  Exception? get exception;
  Error? get error;
  StackTrace? get stackTrace;
  Map<String, dynamic>? get additional;
  DateTime get time;
  String generateTextMessage();
}

extension GetTitle on TalkerDataInterface {
  String get titleText {
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

  String get displayStackTrace {
    if (stackTrace == null) {
      return '';
    }
    return '\n${stackTrace ?? ''}';
  }

  String get displayException {
    if (exception == null) {
      return '';
    }
    return '\n$exception';
  }

  String get displayError {
    if (error == null) {
      return '';
    }
    return '\nError: $error';
  }

  String get displayAditional {
    if (additional == null) {
      return '';
    }
    return '\n$additional';
  }

  String get displayMessage {
    if (message == null) {
      return '';
    }
    return '$message';
  }

  String get displayTime => TalkerDateTimeFormater(time).timeAndSeconds;
}
