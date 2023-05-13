import 'package:talker_logger/talker_logger.dart';

/// This formatter makes messages colorful
/// if this setting is enabled in the settings [TalkerLoggerSettings]
class ColoredLoggerFormatter implements LoggerFormatter {
  const ColoredLoggerFormatter();

  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final underline = ConsoleUtils.getUnderline(
      settings.maxLineWidth,
      lineSymbol: settings.lineSymbol,
    );
    final msg = details.message?.toString() ?? '';
    if (!settings.enableColors) {
      return '$msg\n$underline';
    }
    var lines = msg.split('\n');
    lines = lines.map((e) => details.pen.write(e)).toList();
    lines.add(details.pen.write(underline));
    final coloredMsg = lines.join('\n');
    return coloredMsg;
  }
}
