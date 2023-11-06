import 'package:talker_logger/talker_logger.dart';

const _defaultLogTitles = {
  LogLevel.critical: 'CRITICAL',
  LogLevel.error: 'ERROR',
  LogLevel.warning: 'WARNING',
  LogLevel.verbose: 'VERBOSE',
  LogLevel.info: 'INFO',
  LogLevel.debug: 'DEBUG',
};

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
    this.titles = _defaultLogTitles,
    this.defaultTitle = 'LOG',
    this.level = LogLevel.verbose,
    this.lineSymbol = '─',
    this.maxLineWidth = 110,
    this.enableColors = true,
  }) {
    colors = colors ?? _defaultColors;
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
  late final Map<LogLevel, AnsiPen> colors;

  /// Field to setup custom log titles
  ///```dart
  /// final logger = TalkerLogger(
  ///   settings: TalkerLoggerSettings(
  ///     colors: {
  ///       LogLevel.critical: 'OH nooo! ☠️☠️☠️',
  ///       LogLevel.error: '🆘 Lock at me! 🆘',
  ///       LogLevel.info: 'i',
  ///     },
  ///     enableColors: true,
  ///   ),
  /// );
  /// ```
  final Map<LogLevel, String> titles;

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
    Map<LogLevel, String>? titles,
    String? defaultTitle,
    LogLevel? level,
    String? lineSymbol,
    int? maxLineWidth,
    bool? enableColors,
  }) {
    return TalkerLoggerSettings(
      colors: colors ?? this.colors,
      titles: titles ?? this.titles,
      defaultTitle: defaultTitle ?? this.defaultTitle,
      level: level ?? this.level,
      lineSymbol: lineSymbol ?? this.lineSymbol,
      maxLineWidth: maxLineWidth ?? this.maxLineWidth,
      enableColors: enableColors ?? this.enableColors,
    );
  }
}
