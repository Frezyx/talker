import 'package:talker_logger/talker_logger.dart';

class TalkerLogger {
  TalkerLogger({
    this.settings = kDefaultLoggerSettings,
    TalkerLoggerFilter? filter,
    this.formater = const ExtendedLoggerFormatter(),
    void Function(String message)? output,
  }) {
    // ignore: avoid_print
    _output = output ?? (String message) => message.split('\n').forEach(print);
    _filter = filter ?? LogLevelTalkerLoggerFilter(settings.level);
    ansiColorDisabled = false;
  }

  /// Logger settings
  final TalkerLoggerSettings settings;

  /// Logs formatter
  final LoggerFormatter formater;

  late final void Function(String message) _output;
  late final TalkerLoggerFilter _filter;

  /// {@template talker_logger_log}
  /// Log a new custom message
  /// [String] [msg] - message describes what happened
  /// [LogLevel] [level] - level of logs to segmentation фтв control logging output
  /// [AnsiPen] [pen] - console pen to setting log color
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.log('Log custom message', level: LogLevel.error, pen: AnsiPen()..red());
  /// ```
  /// {@endtemplate}

  void log(dynamic msg, {LogLevel? level, AnsiPen? pen}) {
    final selectedPen = pen ?? settings.colors[level] ?? level.consoleColor;
    final selectedLevel = level ?? LogLevel.debug;
    if (_filter.shouldLog(msg, selectedLevel)) {
      final formatedMsg = formater.fmt(
        LogDetails(message: msg, level: selectedLevel, pen: selectedPen),
        settings,
      );
      _output(formatedMsg);
    }
  }

  /// {@template talker_logger_critical_log}
  /// Log a new critical message
  /// [String] [msg] - message describes what happened
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.critical('Log critical message');
  /// ```
  /// {@endtemplate}

  void critical(dynamic msg) => log(msg, level: LogLevel.critical);

  /// {@template talker_logger_error_log}
  /// Log a new error message
  /// [String] [msg] - message describes what happened
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.error('Log error message');
  /// ```
  /// {@endtemplate}

  void error(dynamic msg) => log(msg, level: LogLevel.error);

  /// {@template talker_logger_warning_log}
  /// Log a new warning message
  /// [String] [msg] - message describes what happened
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.warning('Log warning message');
  /// ```
  /// {@endtemplate}

  void warning(dynamic msg) => log(msg, level: LogLevel.warning);

  /// {@template talker_logger_debug_log}
  /// Log a new debug message
  /// [String] [msg] - message describes what happened
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.debug('Log debug message');
  /// ```
  /// {@endtemplate}

  void debug(dynamic msg) => log(msg);

  /// {@template talker_logger_verbose_log}
  /// Log a new verbose message
  /// [String] [msg] - message describes what happened
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.verbose('Log verbose message');
  /// ```
  /// {@endtemplate}

  void verbose(dynamic msg) => log(msg, level: LogLevel.verbose);

  /// {@template talker_logger_info_log}
  /// Log a new info message
  /// [String] [msg] - message describes what happened
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.info('Log info message');
  /// ```
  /// {@endtemplate}

  void info(dynamic msg) => log(msg, level: LogLevel.info);

  /// {@template talker_logger_fine_log}
  /// Log a new fine message
  /// [String] [msg] - message describes what happened
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.fine('Log fine message');
  /// ```
  /// {@endtemplate}
  @Deprecated(
    "Will be removed in a future release. Use any of other log methods",
  )
  void fine(dynamic msg) => log(msg, level: LogLevel.fine);

  /// {@template talker_logger_good_log}
  /// Log a new good message
  /// [String] [msg] - message describes what happened
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.good('Log good message');
  /// ```
  /// {@endtemplate}

  void good(dynamic msg) => log(msg, level: LogLevel.good);

  TalkerLogger copyWith({
    TalkerLoggerSettings? settings,
    LoggerFormatter? formater,
    TalkerLoggerFilter? filter,
    Function(String message)? output,
  }) {
    return TalkerLogger(
      settings: settings ?? this.settings,
      formater: formater ?? this.formater,
      filter: filter ?? _filter,
      output: output ?? _output,
    );
  }
}
