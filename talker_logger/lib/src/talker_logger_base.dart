import 'package:talker_logger/talker_logger.dart';

class TalkerLogger {
  TalkerLogger({
    this.settings = kDefaultLoggerSettings,
    TalkerLoggerFilter? filter,
  }) {
    filter = filter ?? BaseTalkerLoggerFilter(settings.logLevel);
  }

  final TalkerLoggerSettings settings;
  late final TalkerLoggerFilter _filter;

  void log(String msg, {LogLevel logLevel = LogLevel.debug}) {
    var pen = settings.colors[logLevel];
    pen = pen ?? logLevel.consoleColor;

    if (_filter.shouldLog(msg, logLevel)) {
      consolePrint(pen.write(msg));
    }
  }

  void consolePrint(String msg) {
    print(msg);
  }
}
