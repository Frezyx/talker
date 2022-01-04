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
    return '[$title]' + ' | ${DateTimeFormater(time).timeAndSeconds} | ';
  }

  String get consoleStackTrace {
    if (stackTrace == null) {
      return '';
    }
    return '\nStackTrace:\n${stackTrace ?? ''}';
  }

  String get consoleException {
    if (exception == null) {
      return '';
    }
    return '\nException: $exception';
  }

  String get consoleError {
    if (error == null) {
      return '';
    }
    return '\nError: $error';
  }

  String get consoleAditional {
    if (additional == null) {
      return '';
    }
    return '\n$additional';
  }
}
