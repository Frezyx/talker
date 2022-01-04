import 'package:talker/talker.dart';

abstract class TalkerDataInterface {
  String? get message;
  LogLevel? get logLevel;
  Exception? get exception;
  Error? get error;
  StackTrace? get stackTrace;
  Map<String, dynamic>? get additional;
  String generateTextMessage();
}

extension GetTitle on TalkerDataInterface {
  String getTitleText() {
    switch (runtimeType) {
      case TalkerError:
        return 'ERROR';
      case TalkerException:
        return 'EXCEPTION';
      case TalkerLog:
        return logLevel.title;
      default:
        return 'DEAFULT';
    }
  }
}
