import 'package:talker_logger/talker_logger.dart';

class BaseLoggerFormater implements LoggerFormater {
  const BaseLoggerFormater();

  @override
  String fmt(LogDetails details) {
    var lines = details.message.split('\n');
    lines = lines.map((e) => details.pen.write(e)).toList();
    lines.add(ConsoleFormater.getUnderline(details.maxLineWidth, details.pen));
    final coloredMsg = lines.join('\n');
    return coloredMsg;
  }
}
