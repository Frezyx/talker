import 'package:talker_logger/talker_logger.dart';

class BaseLoggerFormater implements LoggerFormater {
  const BaseLoggerFormater();

  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final underline = ConsoleFormater.getUnderline(
      settings.maxLineWidth,
      lineSymbol: settings.lineSymbol,
    );
    if (!settings.enableColors) {
      return '${details.message}\n$underline';
    }
    var lines = details.message.split('\n');
    lines = lines.map((e) => details.pen.write(e)).toList();
    lines.add(details.pen.write(underline));
    final coloredMsg = lines.join('\n');
    return coloredMsg;
  }
}
