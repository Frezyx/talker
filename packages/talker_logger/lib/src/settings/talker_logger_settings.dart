import 'package:talker_logger/talker_logger.dart';

const kDefaultLoggerSettings = TalkerLoggerSettings();

class TalkerLoggerSettings {
  const TalkerLoggerSettings({
    this.colors = const {},
    this.level = LogLevel.good,
    this.lineSymbol = '-',
    this.maxLineWidth = 110,
    this.enableColors = true,
  });

  final Map<LogLevel, AnsiPen> colors;
  final LogLevel level;
  final String lineSymbol;
  final int maxLineWidth;
  final bool enableColors;
}
