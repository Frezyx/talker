import 'package:talker_logger/talker_logger.dart';

/// Responsible for formatting message before output
///
/// [ColoredLoggerFormater] is used by default
/// You can create your own filter by implementing [LoggerFormater]
/// or use [ColoredLoggerFormater].
abstract class LoggerFormater {
  /// Formats the message in the appropriate way
  String fmt(LogDetails details, TalkerLoggerSettings settings);
}
