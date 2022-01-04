import 'package:talker_logger/talker_logger.dart';

class TalkerLogger {
  TalkerLogger({
    this.settings = kDefaultLoggerSettings,
  });
  final TalkerLoggerSettings settings;

  void log(String msg, {LogLevel logLevel = LogLevel.debug}) {
    var pen = settings.colors[logLevel];
    pen = pen ?? logLevel.consoleColor;
    consolePrint(pen.write(msg));
  }

  void consolePrint(String msg) {
    print(msg);
  }
}
