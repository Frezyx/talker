import 'package:talker_logger/talker_logger.dart';

class TalkerLogger implements TalkerLoggerInterface {
  TalkerLogger({
    this.settings = kDefaultLoggerSettings,
    TalkerLoggerFilter? filter,
    this.formater = const BaseLoggerFormater(),
  }) {
    _filter = filter ?? BaseTalkerLoggerFilter(settings.level);
  }

  final TalkerLoggerSettings settings;

  final LoggerFormater formater;
  late final TalkerLoggerFilter _filter;

  @override
  void log(String msg, {LogLevel? level, AnsiPen? pen}) {
    final selectedPen = pen ?? settings.colors[level] ?? level.consoleColor;
    final selectedLevel = level ?? LogLevel.debug;
    if (_filter.shouldLog(msg, selectedLevel)) {
      _consolePrint(
        formater.fmt(
          LogDetails(
            message: msg,
            level: selectedLevel,
            pen: selectedPen,
            lineSymbol: settings.lineSymbol,
            maxLineWidth: settings.maxLineWidth,
          ),
        ),
      );
    }
  }

  @override
  void critical(String msg) => log(msg, level: LogLevel.critical);

  @override
  void debug(String msg) => log(msg);

  @override
  void error(String msg) => log(msg, level: LogLevel.error);

  @override
  void fine(String msg) => log(msg, level: LogLevel.fine);

  @override
  void good(String msg) => log(msg, level: LogLevel.good);

  @override
  void info(String msg) => log(msg, level: LogLevel.info);

  @override
  void verbose(String msg) => log(msg, level: LogLevel.verbose);

  @override
  void warning(String msg) => log(msg, level: LogLevel.warning);

  void _consolePrint(String msg) {
    // ignore: avoid_print
    print(msg);
  }
}
