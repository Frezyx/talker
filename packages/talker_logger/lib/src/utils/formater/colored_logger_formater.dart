import 'package:talker_logger/talker_logger.dart';

/// This formatter makes messages colorful
/// if this setting is enabled in the settings [TalkerLoggerSettings]
class ColoredLoggerFormater implements LoggerFormater {
  const ColoredLoggerFormater();

  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final underline = ConsoleUtils.getUnderline(
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
