import 'package:talker_logger/talker_logger.dart';

class BaseLoggerFormater implements LoggerFormater {
  const BaseLoggerFormater();

  @override
  String fmt(LogDetails details) {
    final lines = <String>[];
    final chars = details.message.split('');

    final countParts = (chars.length / details.maxLineWidth).round();
    final lastPart = chars.length % details.maxLineWidth;

    if (countParts == 0) {
      lines.add(details.pen.write(chars.join()));
    }

    for (var i = 0; i < countParts; i++) {
      var end = (i + 1) * details.maxLineWidth;
      if (i == countParts - 1) {
        end = lastPart + i * details.maxLineWidth;
      }
      final linechars = chars.getRange(i * details.maxLineWidth, end);
      lines.add(details.pen.write(linechars.join()));
    }

    lines.add(ConsoleFormater.getUnderline(details.maxLineWidth, details.pen));

    final coloredMsg = lines.join('\n');
    return coloredMsg;
  }
}
