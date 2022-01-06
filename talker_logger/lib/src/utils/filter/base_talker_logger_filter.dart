import 'package:talker_logger/talker_logger.dart';

class BaseTalkerLoggerFilter implements TalkerLoggerFilter {
  const BaseTalkerLoggerFilter(this.logLevel);
  final LogLevel logLevel;

  @override
  bool shouldLog(String msg, LogLevel level) {
    final currLogLevelIndex = logLevelPriorityList.indexOf(logLevel);
    final msgLogLevelIndex = logLevelPriorityList.indexOf(level);
    return currLogLevelIndex >= msgLogLevelIndex;
  }
}
