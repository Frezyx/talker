/// Level of logs to segmentation and control logging output
enum LogLevel {
  /// Errors
  error('error'),
  critical('critical'),

  /// Messages
  info('info'),
  debug('debug'),
  verbose('verbose'),
  warning('warning');

  const LogLevel(this.id);
  final String id;

  factory LogLevel.fromId(String id) {
    return LogLevel.values.firstWhere((e) => e.id == id);
  }
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
