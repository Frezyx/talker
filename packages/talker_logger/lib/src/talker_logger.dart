import 'package:talker_logger/talker_logger.dart';

class TalkerLogger implements TalkerLoggerInterface {
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

  final TalkerLoggerSettings settings;
  final LoggerFormatter formater;
  late final void Function(String message) _output;
  late final TalkerLoggerFilter _filter;

  /// {@macro talker_logger_log}
  @override
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

  /// {@macro talker_logger_critical_log}
  @override
  void critical(dynamic msg) => log(msg, level: LogLevel.critical);

  /// {@macro talker_logger_debug_log}
  @override
  void debug(dynamic msg) => log(msg);

  /// {@macro talker_logger_error_log}
  @override
  void error(dynamic msg) => log(msg, level: LogLevel.error);

  /// {@macro talker_logger_fine_log}
  @override
  void fine(dynamic msg) => log(msg, level: LogLevel.fine);

  /// {@macro talker_logger_good_log}
  @override
  void good(dynamic msg) => log(msg, level: LogLevel.good);

  /// {@macro talker_logger_info_log}
  @override
  void info(dynamic msg) => log(msg, level: LogLevel.info);

  /// {@macro talker_logger_verbose_log}
  @override
  void verbose(dynamic msg) => log(msg, level: LogLevel.verbose);

  /// {@macro talker_logger_warning_log}
  @override
  void warning(dynamic msg) => log(msg, level: LogLevel.warning);

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
