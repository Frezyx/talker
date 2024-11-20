import 'package:talker/talker.dart';

final _defaultTitles = {
  /// Base logs section
  TalkerLogType.critical.key: 'critical',
  TalkerLogType.warning.key: 'warning',
  TalkerLogType.verbose.key: 'verbose',
  TalkerLogType.info.key: 'info',
  TalkerLogType.debug.key: 'debug',
  TalkerLogType.error.key: 'error',
  TalkerLogType.exception.key: 'exception',

  /// Http section
  TalkerLogType.httpError.key: 'http-error',
  TalkerLogType.httpRequest.key: 'http-request',
  TalkerLogType.httpResponse.key: 'http-response',

  /// Bloc section
  TalkerLogType.blocEvent.key: 'bloc-event',
  TalkerLogType.blocTransition.key: 'bloc-transition',
  TalkerLogType.blocCreate.key: 'bloc-create',
  TalkerLogType.blocClose.key: 'bloc-close',

  /// Riverpod section
  TalkerLogType.riverpodAdd.key: 'riverpod-add',
  TalkerLogType.riverpodUpdate.key: 'riverpod-update',
  TalkerLogType.riverpodDispose.key: 'riverpod-dispose',
  TalkerLogType.riverpodFail.key: 'riverpod-fail',

  /// Flutter section
  TalkerLogType.route.key: 'route',
};

final _defaultColors = {
  /// Base logs section
  TalkerLogType.critical.key: AnsiPen()..red(),
  TalkerLogType.warning.key: AnsiPen()..yellow(),
  TalkerLogType.verbose.key: AnsiPen()..gray(),
  TalkerLogType.info.key: AnsiPen()..blue(),
  TalkerLogType.debug.key: AnsiPen()..gray(),
  TalkerLogType.error.key: AnsiPen()..red(),
  TalkerLogType.exception.key: AnsiPen()..red(),

  /// Http section
  TalkerLogType.httpError.key: AnsiPen()..red(),
  TalkerLogType.httpRequest.key: AnsiPen()..xterm(219),
  TalkerLogType.httpResponse.key: AnsiPen()..xterm(46),

  /// Bloc section
  TalkerLogType.blocEvent.key: AnsiPen()..xterm(51),
  TalkerLogType.blocTransition.key: AnsiPen()..xterm(49),
  TalkerLogType.blocCreate.key: AnsiPen()..xterm(35),
  TalkerLogType.blocClose.key: AnsiPen()..xterm(198),

  /// Riverpod section
  TalkerLogType.riverpodAdd.key: AnsiPen()..xterm(51),
  TalkerLogType.riverpodUpdate.key: AnsiPen()..xterm(49),
  TalkerLogType.riverpodDispose.key: AnsiPen()..xterm(198),
  TalkerLogType.riverpodFail.key: AnsiPen()..red(),

  /// Flutter section
  TalkerLogType.route.key: AnsiPen()..xterm(135),
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
  ///   TalkerTitle.info.key: "Information",
  ///   TalkerTitle.error.key: "Error",
  ///   TalkerTitle.warning.key: "Warning",
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
  ///   TalkerKey.info.key: AnsiPen()..white(bold: true),
  ///   TalkerKey.error.key: AnsiPen()..red(bold: true),
  ///   TalkerKey.warning.key: AnsiPen()..yellow(bold: true),
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

  String getTitleByLogKey(String key) {
    return titles[key] ?? key;
  }

  AnsiPen getAnsiPenByLogType(TalkerLogType type, {TalkerData? logData}) =>
      getPenByLogKey(type.key, fallbackPen: logData?.pen);

  AnsiPen getPenByLogKey(String key, {AnsiPen? fallbackPen}) {
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
