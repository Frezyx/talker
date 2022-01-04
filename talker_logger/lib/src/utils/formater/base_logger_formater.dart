import 'package:talker_logger/talker_logger.dart';

class BaseLoggerFormater implements LoggerFormater {
  const BaseLoggerFormater();
  @override
  String fmt(String msg, LogLevel level) {
    return msg;
  }
}
