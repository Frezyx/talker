import 'package:talker_logger/talker_logger.dart';

/// Level of logs to segmentation фтв control logging output
enum LogLevel {
  /// Errors
  error,
  critical,

  /// Messages
  info,
  good,
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
  LogLevel.good,
  LogLevel.debug,
  LogLevel.verbose,
];

/// Extension to get console log [AnsiPen] of log level
/// to make colored message
extension ToConsoleColor on LogLevel? {
  /// console log [AnsiPen] of log level to make colored message
  AnsiPen get consoleColor {
    switch (this) {
      case LogLevel.error:
        return AnsiPen()..red();
      case LogLevel.debug:
        return AnsiPen()..gray();
      case LogLevel.critical:
        return AnsiPen()..red();
      case LogLevel.warning:
        return AnsiPen()..yellow();
      case LogLevel.verbose:
        return AnsiPen()..gray();
      case LogLevel.info:
        return AnsiPen()..blue();
      case LogLevel.good:
        return AnsiPen()..green();
      default:
        return AnsiPen()..white();
    }
  }
}
