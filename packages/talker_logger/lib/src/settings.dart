import 'package:talker_logger/talker_logger.dart';

final _defaultColors = {
  LogLevel.critical: AnsiPen()..red(),
  LogLevel.error: AnsiPen()..red(),
  LogLevel.warning: AnsiPen()..yellow(),
  LogLevel.verbose: AnsiPen()..gray(),
  LogLevel.info: AnsiPen()..blue(),
  LogLevel.debug: AnsiPen()..gray(),
};

/// Logger customization settings
class TalkerLoggerSettings {
  TalkerLoggerSettings({
    Map<LogLevel, AnsiPen>? colors,
    this.enable = true,
    this.defaultTitle = 'LOG',
    this.level = LogLevel.verbose,
    this.lineSymbol = '─',
    this.maxLineWidth = 110,
    this.enableColors = true,
  }) {
    if (colors != null) {
      _defaultColors.addAll(colors);
    }
    this.colors.addAll(_defaultColors);
  }

  /// Field to setup custom log colors
  ///```dart
  /// final logger = TalkerLogger(
  ///   settings: TalkerLoggerSettings(
  ///     colors: {
  ///       LogLevel.critical: AnsiPen()..red(),
  ///       LogLevel.error: AnsiPen()..magenta(),
  ///       LogLevel.info: AnsiPen()..cyan(),
  ///     },
  ///     enableColors: true,
  ///   ),
  /// );
  /// ```
  final Map<LogLevel, AnsiPen> colors = _defaultColors;

  ///  Field for enable and disable print logger
  bool enable;

  /// Title of default log without [LogLevel]
  final String defaultTitle;

  /// Current log level
  /// All messages with a priority below this will be ignored
  final LogLevel level;

  ///The symbol separating logs by lower border
  final String lineSymbol;

  /// Maximum width of the lower border
  final int maxLineWidth;

  /// Field for enable and disable colored logs
  final bool enableColors;

  TalkerLoggerSettings copyWith({
    Map<LogLevel, AnsiPen>? colors,
    String? defaultTitle,
    LogLevel? level,
    String? lineSymbol,
    int? maxLineWidth,
    bool? enableColors,
  }) {
    return TalkerLoggerSettings(
      colors: colors ?? this.colors,
      defaultTitle: defaultTitle ?? this.defaultTitle,
      level: level ?? this.level,
      lineSymbol: lineSymbol ?? this.lineSymbol,
      maxLineWidth: maxLineWidth ?? this.maxLineWidth,
      enableColors: enableColors ?? this.enableColors,
    );
  }
}
