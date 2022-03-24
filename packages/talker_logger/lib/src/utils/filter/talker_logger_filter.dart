import 'package:talker_logger/talker_logger.dart';

/// Abstract filter for messages logging.
/// You can create your own filter by implementing [TalkerLoggerFilter]
/// or use [LogLevelTalkerLoggerFilter].
abstract class TalkerLoggerFilter {
  /// This method checks every message
  /// Displays a message if [true] is returned,
  /// and not display if [false]
  bool shouldLog(String msg, LogLevel level);
}
