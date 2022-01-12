import 'package:talker_logger/talker_logger.dart';

class BaseLoggerFormater implements LoggerFormater {
  const BaseLoggerFormater();

  @override
  String fmt(LogDetails details) {
    final parts = details.message.split('\n');
    final coloredMsg = parts.map((e) => details.pen.write(e)).join('\n');
    return ConsoleFormater.addUnderline(coloredMsg, details.pen);
  }
}
