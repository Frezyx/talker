import 'package:talker_logger/talker_logger.dart';

abstract class LoggerFormater {
  String fmt(String msg, LogLevel level, AnsiPen pen);
}
