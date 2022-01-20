import 'package:talker/talker.dart';

extension ToLogLevel on ErrorLevel? {
  /// Converted [ErrorLevel] in [LogLevel]
  LogLevel get loglevel {
    switch (this) {
      case ErrorLevel.critical:
        return LogLevel.critical;
      case ErrorLevel.info:
        return LogLevel.info;
      case ErrorLevel.tiny:
        return LogLevel.verbose;
      case ErrorLevel.warning:
        return LogLevel.warning;
      case ErrorLevel.debug:
      case null:
        return LogLevel.error;
    }
  }
}
