import 'package:talker_logger/talker_logger.dart';

class BaseLoggerFormater implements LoggerFormater {
  const BaseLoggerFormater();

  @override
  String fmt(String msg, LogLevel level, AnsiPen pen) {
    final parts = msg.split('\n');
    final coloredMsg = parts.map((e) => pen.write(e)).join('\n');
    return ConsoleFormater.addUnderline(coloredMsg, pen);
  }
}
