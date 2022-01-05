import 'package:talker_logger/talker_logger.dart';

class TalkerLogger {
  TalkerLogger({
    this.settings = kDefaultLoggerSettings,
    TalkerLoggerFilter? filter,
    this.formater = const BaseLoggerFormater(),
  }) {
    _filter = filter ?? BaseTalkerLoggerFilter(settings.logLevel);
  }

  final TalkerLoggerSettings settings;
  late final TalkerLoggerFilter _filter;
  final LoggerFormater formater;

  void log(String msg, {LogLevel logLevel = LogLevel.debug}) {
    var pen = settings.colors[logLevel];
    pen = pen ?? logLevel.consoleColor;

    if (_filter.shouldLog(msg, logLevel)) {
      consolePrint(
        formater.fmt(msg, logLevel, pen),
      );
    }
  }

  void consolePrint(String msg) {
    // ignore: avoid_print
    print(msg);
  }
}
