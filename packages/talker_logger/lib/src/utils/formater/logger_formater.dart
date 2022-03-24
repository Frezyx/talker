import 'package:talker_logger/talker_logger.dart';

abstract class LoggerFormater {
  String fmt(LogDetails details, TalkerLoggerSettings settings);
}
