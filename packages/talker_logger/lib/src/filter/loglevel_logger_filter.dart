import 'package:talker_logger/talker_logger.dart';

/// This filter checks that current message level
/// is above certain [LogLevel] setting in [TalkerLoggerSettings]
class LogLevelFilter implements LoggerFilter {
  const LogLevelFilter(this.logLevel);

  final LogLevel logLevel;

  @override
  bool shouldLog(dynamic msg, LogLevel level) {
    final currLogLevelIndex = logLevelPriorityList.indexOf(logLevel);
    final msgLogLevelIndex = logLevelPriorityList.indexOf(level);
    return currLogLevelIndex >= msgLogLevelIndex;
  }
}
