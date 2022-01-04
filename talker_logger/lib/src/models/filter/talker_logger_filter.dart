import 'package:talker_logger/talker_logger.dart';

abstract class TalkerLoggerFilter {
  bool shouldLog(String msg, LogLevel level);
}
