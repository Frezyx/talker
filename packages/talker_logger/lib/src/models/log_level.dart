import 'package:talker_logger/talker_logger.dart';

/// Level of logs to segmentation фтв control logging output
enum LogLevel {
  /// Errors
  error,
  critical,

  /// Messages
  info,
  fine,
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
  LogLevel.debug,
  LogLevel.verbose,
  LogLevel.info,
  LogLevel.fine,
  LogLevel.good
];

/// Extension to get console log title of log level
extension LogLevelTitle on LogLevel? {
  /// Console log title of log level
  String get title {
    switch (this) {
      case LogLevel.critical:
        return 'CRITICAL';
      case LogLevel.error:
        return 'ERROR';
      case LogLevel.fine:
        return 'FINE';
      case LogLevel.warning:
        return 'WARNING';
      case LogLevel.verbose:
        return 'VERBOSE';
      case LogLevel.info:
        return 'INFO';
      case LogLevel.good:
        return 'GOOD';
      case LogLevel.debug:
        return 'DEBUG';
      default:
        return 'LOG';
    }
  }
}

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
      case LogLevel.fine:
        return AnsiPen()..cyan();
      case LogLevel.good:
        return AnsiPen()..green();
      default:
        return AnsiPen()..white();
    }
  }
}
