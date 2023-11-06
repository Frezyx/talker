/// Level of logs to segmentation фтв control logging output
enum LogLevel {
  /// Errors
  error,
  critical,

  /// Messages
  info,
  debug,
  verbose,
  warning,
}

/// List of levels sorted by priority
final logLevelPriorityList = [
  LogLevel.critical,
  LogLevel.error,
  LogLevel.warning,
  LogLevel.info,
  LogLevel.debug,
  LogLevel.verbose,
];
