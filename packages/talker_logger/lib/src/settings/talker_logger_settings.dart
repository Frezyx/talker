import 'package:talker_logger/talker_logger.dart';

const kDefaultLoggerSettings = TalkerLoggerSettings();

/// Logger customization settings
class TalkerLoggerSettings {
  const TalkerLoggerSettings({
    this.colors = const {},
    this.level = LogLevel.good,
    this.lineSymbol = '─',
    this.maxLineWidth = 110,
    this.enableColors = true,
  });

  /// Field to setup custom log colors
  ///```dart
  /// final logger = TalkerLogger(
  ///   settings: TalkerLoggerSettings(
  ///     colors: {
  ///       LogLevel.critical: AnsiPen()..red(),
  ///       LogLevel.error: AnsiPen()..magenta(),
  ///       LogLevel.info: AnsiPen()..cyan(),
  ///       LogLevel.fine: AnsiPen()..yellow(),
  ///     },
  ///     enableColors: true,
  ///   ),
  /// );
  /// ```
  final Map<LogLevel, AnsiPen> colors;

  /// Current log level
  /// All messages with a priority below this will be ignored
  final LogLevel level;

  ///The symbol separating logs by lower border
  final String lineSymbol;

  /// Maximum width of the lower border
  final int maxLineWidth;

  /// Field for enable and disable colored logs
  final bool enableColors;
}
