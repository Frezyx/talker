import 'package:talker_logger/talker_logger.dart';

const kDefaultLoggerSettings = TalkerLoggerSettings();

class TalkerLoggerSettings {
  const TalkerLoggerSettings({
    this.colors = const {},
    this.logLevel = LogLevel.good,
  });

  final Map<LogLevel, AnsiPen> colors;
  final LogLevel logLevel;
}
