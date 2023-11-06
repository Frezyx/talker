import 'package:talker/talker.dart';

const _defaultTitles = {
  TalkerLogType.error: 'error',
  TalkerLogType.exception: 'exception',
  TalkerLogType.httpError: 'http-error',
  TalkerLogType.httpRequest: 'http-request',
  TalkerLogType.httpResponse: 'http-response',
  TalkerLogType.blocEvent: 'bloc-event',
  TalkerLogType.blocTransition: 'bloc-transition',
  TalkerLogType.route: 'route',
  TalkerLogType.critical: 'critical',
  TalkerLogType.warning: 'warning',
  TalkerLogType.verbose: 'verbose',
  TalkerLogType.info: 'info',
  TalkerLogType.debug: 'debug',
};

final _defaultColors = {
  TalkerLogType.error: AnsiPen()..red(),
  TalkerLogType.exception: AnsiPen()..red(),
  TalkerLogType.httpError: AnsiPen()..red(),
  TalkerLogType.httpRequest: AnsiPen()..xterm(219),
  TalkerLogType.httpResponse: AnsiPen()..xterm(46),
  TalkerLogType.blocEvent: AnsiPen()..xterm(51),
  TalkerLogType.blocTransition: AnsiPen()..xterm(49),
  TalkerLogType.route: AnsiPen()..xterm(135),
  TalkerLogType.critical: AnsiPen()..red(),
  TalkerLogType.warning: AnsiPen()..yellow(),
  TalkerLogType.verbose: AnsiPen()..gray(),
  TalkerLogType.info: AnsiPen()..blue(),
  TalkerLogType.debug: AnsiPen()..gray(),
};

/// {@template talker_settings}
/// This class used for setup [Talker] configuration
/// {@endtemplate}
class TalkerSettings {
  TalkerSettings({
    this.enabled = true,
    bool useHistory = true,
    bool useConsoleLogs = true,
    int maxHistoryItems = 1000,
    this.titles = _defaultTitles,
    Map<TalkerLogType, AnsiPen>? colors,
    // bool writeToFile = false,
  })  : _useHistory = useHistory,
        _useConsoleLogs = useConsoleLogs,
        _maxHistoryItems = maxHistoryItems {
    colors = colors ?? _defaultColors;
  }
  // _writeToFile = writeToFile;

  /// By default talker write all Errors / Exceptions and logs in history list
  /// (base dart [List] field in core)
  /// If [true] - writing in history
  /// If [false] - not writing
  bool get useHistory => _useHistory && enabled;
  final bool _useHistory;

  /// By default talker print all Errors / Exceptions and logs in console.
  /// If [true] - printing in history [false] - not printing.
  bool get useConsoleLogs => _useConsoleLogs && enabled;
  final bool _useConsoleLogs;

  /// Max records count in history list
  int get maxHistoryItems => _maxHistoryItems;
  final int _maxHistoryItems;

  /// Use writing talker records in file
  // bool get writeToFile => _writeToFile && enabled;
  // final bool _writeToFile;

  /// The main rule that is responsible
  /// for the operation of the package
  /// All log and handle error / exception methods are working when [true] and not working when [false]
  bool enabled;

  /// Custom Logger Titles.
  ///
  /// The `titles` field is intended for storing custom titles for the logger, associated with various log types.
  /// Each title is associated with a specific log type represented as an enum called `TalkerTitle`. This allows you to
  /// provide informative and unique titles for each log type, making logging more readable and informative.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// final customTitles = {
  ///   TalkerTitle.info: "Information",
  ///   TalkerTitle.error: "Error",
  ///   TalkerTitle.warning: "Warning",
  /// };
  ///
  /// final logger = Talker(
  ///   settings: TalkerSettings(
  ///     titles: customTitles,
  ///   )
  /// );
  /// ```
  final Map<TalkerLogType, String> titles;

  /// Custom Logger Colors.
  ///
  /// The `colors` field is designed for setting custom text colors for the logger, associated with specific log keys.
  /// Each color is associated with a specific log key represented as an enum called `TalkerKey`. This allows you to
  /// define custom text colors for each log key, enhancing the visual representation of logs in the console.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// final customColors = {
  ///   TalkerKey.info: AnsiPen()..white(bold: true),
  ///   TalkerKey.error: AnsiPen()..red(bold: true),
  ///   TalkerKey.warning: AnsiPen()..yellow(bold: true),
  /// };
  ///
  /// final logger = Talker(
  ///   settings: TalkerSettings(
  ///     colors: customColors,
  ///   )
  /// );
  /// ```
  ///
  /// By using the `colors` field, you can customize the text colors for specific log keys in the console.
  late final Map<TalkerLogType, AnsiPen> colors;

  String getTitleByLogType(TalkerLogType key) {
    return titles[key] ?? 'log';
  }

  AnsiPen getAnsiPenByLogType(TalkerLogType key) {
    return colors[key] ?? (AnsiPen()..gray());
  }

  TalkerSettings copyWith({
    bool? enabled,
    bool? useHistory,
    bool? useConsoleLogs,
    int? maxHistoryItems,
    Map<TalkerLogType, String>? titles,
    Map<TalkerLogType, AnsiPen>? colors,
  }) {
    return TalkerSettings(
      useHistory: useHistory ?? _useHistory,
      useConsoleLogs: useConsoleLogs ?? _useConsoleLogs,
      maxHistoryItems: maxHistoryItems ?? _maxHistoryItems,
      enabled: enabled ?? this.enabled,
      titles: titles ?? this.titles,
      colors: colors ?? this.colors,
    );
  }
}
