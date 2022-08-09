import 'package:talker_logger/talker_logger.dart';

/// Responsible for formatting message before output
///
/// [ColoredLoggerFormatter] is used by default
/// You can create your own filter by implementing [LoggerFormatter]
/// or use [ColoredLoggerFormatter].
abstract class LoggerFormatter {
  /// Formats the message in the appropriate way
  String fmt(LogDetails details, TalkerLoggerSettings settings);
}
