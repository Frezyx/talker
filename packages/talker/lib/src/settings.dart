import 'package:talker/talker.dart';

final _defaultTitles = {
  /// Base logs section
  TalkerKey.critical: 'critical',
  TalkerKey.warning: 'warning',
  TalkerKey.verbose: 'verbose',
  TalkerKey.info: 'info',
  TalkerKey.debug: 'debug',
  TalkerKey.error: 'error',
  TalkerKey.exception: 'exception',

  /// Http section
  TalkerKey.httpError: 'http-error',
  TalkerKey.httpRequest: 'http-request',
  TalkerKey.httpResponse: 'http-response',

  /// Bloc section
  TalkerKey.blocEvent: 'bloc-event',
  TalkerKey.blocTransition: 'bloc-transition',
  TalkerKey.blocCreate: 'bloc-create',
  TalkerKey.blocClose: 'bloc-close',

  /// Riverpod section
  TalkerKey.riverpodAdd: 'riverpod-add',
  TalkerKey.riverpodUpdate: 'riverpod-update',
  TalkerKey.riverpodDispose: 'riverpod-dispose',
  TalkerKey.riverpodFail: 'riverpod-fail',

  /// Flutter section
  TalkerKey.route: 'route',
};

final _defaultColors = {
  /// Base logs section
  TalkerKey.critical: AnsiPen()..red(),
  TalkerKey.warning: AnsiPen()..yellow(),
  TalkerKey.verbose: AnsiPen()..gray(),
  TalkerKey.info: AnsiPen()..blue(),
  TalkerKey.debug: AnsiPen()..gray(),
  TalkerKey.error: AnsiPen()..red(),
  TalkerKey.exception: AnsiPen()..red(),

  /// Http section
  TalkerKey.httpError: AnsiPen()..red(),
  TalkerKey.httpRequest: AnsiPen()..xterm(219),
  TalkerKey.httpResponse: AnsiPen()..xterm(46),

  /// Bloc section
  TalkerKey.blocEvent: AnsiPen()..xterm(51),
  TalkerKey.blocTransition: AnsiPen()..xterm(49),
  TalkerKey.blocCreate: AnsiPen()..xterm(35),
  TalkerKey.blocClose: AnsiPen()..xterm(198),

  /// Riverpod section
  TalkerKey.riverpodAdd: AnsiPen()..xterm(51),
  TalkerKey.riverpodUpdate: AnsiPen()..xterm(49),
  TalkerKey.riverpodDispose: AnsiPen()..xterm(198),
  TalkerKey.riverpodFail: AnsiPen()..red(),

  /// Flutter section
  TalkerKey.route: AnsiPen()..xterm(135),
};

final _fallbackPen = AnsiPen()..gray();

/// {@template talker_settings}
/// This class used for setup [Talker] configuration
/// {@endtemplate}
class TalkerSettings {
  TalkerSettings({
    this.enabled = true,
    bool useHistory = true,
    bool useConsoleLogs = true,
    int maxHistoryItems = 1000,
    Map<String, String>? titles,
    Map<String, AnsiPen>? colors,
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  })  : _useHistory = useHistory,
        _useConsoleLogs = useConsoleLogs,
        _maxHistoryItems = maxHistoryItems,
        _timeFormat = timeFormat {
    if (colors != null) {
      _defaultColors.addAll(colors);
    }
    if (titles != null) {
      _defaultTitles.addAll(titles);
    }
    this.colors.addAll(_defaultColors);
    this.titles.addAll(_defaultTitles);
  }
  // _writeToFile = writeToFile;

  /// By default talker write all Errors / Exceptions and logs in history list
  /// (base dart [List] field in core)
  /// If [true] - writing in history
  /// If [false] - not writing
  bool get useHistory => _useHistory && enabled;
  final bool _useHistory;

  /// By default talker print all Errors / Exceptions and logs in console.
  /// If [true] - printing in console [false] - not printing.
  bool get useConsoleLogs => _useConsoleLogs && enabled;
  final bool _useConsoleLogs;

  /// Max records count in history list
  int get maxHistoryItems => _maxHistoryItems;
  final int _maxHistoryItems;

  /// The time format of the logs [TimeFormat]
  TimeFormat get timeFormat => _timeFormat;
  final TimeFormat _timeFormat;

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
  ///   TalkerKey.info: "Information",
  ///   TalkerKey.error: "Error",
  ///   TalkerKey.warning: "Warning",
  /// };
  ///
  /// final logger = Talker(
  ///   settings: TalkerSettings(
  ///     titles: customTitles,
  ///   )
  /// );
  /// ```
  final Map<String, String> titles = _defaultTitles;

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
  final Map<String, AnsiPen> colors = _defaultColors;

  String getTitleByKey(String key) => titles[key] ?? key;

  AnsiPen getPenByKey(String key, {AnsiPen? fallbackPen}) {
    return colors[key] ?? fallbackPen ?? _fallbackPen;
  }

  TalkerSettings copyWith({
    bool? enabled,
    bool? useHistory,
    bool? useConsoleLogs,
    int? maxHistoryItems,
    Map<String, String>? titles,
    Map<String, AnsiPen>? colors,
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
