import 'package:talker_logger/talker_logger.dart';

class TalkerLogger implements TalkerLoggerInterface {
  TalkerLogger({
    this.settings = kDefaultLoggerSettings,
    TalkerLoggerFilter? filter,
    this.formater = const ColoredLoggerFormater(),
  }) {
    _filter = filter ?? LogLevelTalkerLoggerFilter(settings.level);
    ansiColorDisabled = false;
  }

  final TalkerLoggerSettings settings;
  final LoggerFormater formater;
  late final TalkerLoggerFilter _filter;

  /// {@macro talker_logger_log}
  @override
  void log(String msg, {LogLevel? level, AnsiPen? pen}) {
    final selectedPen = pen ?? settings.colors[level] ?? level.consoleColor;
    final selectedLevel = level ?? LogLevel.debug;
    if (_filter.shouldLog(msg, selectedLevel)) {
      final formatedMsg = formater.fmt(
        LogDetails(message: msg, level: selectedLevel, pen: selectedPen),
        settings,
      );
      _consolePrint(formatedMsg);
    }
  }

  /// {@macro talker_logger_critical_log}
  @override
  void critical(String msg) => log(msg, level: LogLevel.critical);

  /// {@macro talker_logger_debug_log}
  @override
  void debug(String msg) => log(msg);

  /// {@macro talker_logger_error_log}
  @override
  void error(String msg) => log(msg, level: LogLevel.error);

  /// {@macro talker_logger_fine_log}
  @override
  void fine(String msg) => log(msg, level: LogLevel.fine);

  /// {@macro talker_logger_good_log}
  @override
  void good(String msg) => log(msg, level: LogLevel.good);

  /// {@macro talker_logger_info_log}
  @override
  void info(String msg) => log(msg, level: LogLevel.info);

  /// {@macro talker_logger_verbose_log}
  @override
  void verbose(String msg) => log(msg, level: LogLevel.verbose);

  /// {@macro talker_logger_warning_log}
  @override
  void warning(String msg) => log(msg, level: LogLevel.warning);

  void _consolePrint(String msg) {
    // ignore: avoid_print
    print(msg);
  }

  TalkerLogger copyWith({
    TalkerLoggerSettings? settings,
    LoggerFormater? formater,
    TalkerLoggerFilter? filter,
  }) {
    return TalkerLogger(
      settings: settings ?? this.settings,
      formater: formater ?? this.formater,
      filter: filter ?? _filter,
    );
  }
}
