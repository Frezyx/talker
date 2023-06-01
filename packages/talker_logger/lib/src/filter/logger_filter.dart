import 'package:talker_logger/talker_logger.dart';

/// Abstract filter for messages logging.
///
/// [LogLevelFilter] is used by default
/// You can create your own filter by implementing [LoggerFilter]
/// or use [LogLevelFilter].
abstract class LoggerFilter {
  /// This method checks every message
  /// Displays a message if [true] is returned,
  /// and not display if [false]
  bool shouldLog(dynamic msg, LogLevel level);
}
