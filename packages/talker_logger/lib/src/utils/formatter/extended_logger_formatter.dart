import 'package:talker_logger/talker_logger.dart';

/// This formatter makes messages colorful
/// if this setting is enabled in the settings [TalkerLoggerSettings]
class ExtendedLoggerFormatter implements LoggerFormatter {
  const ExtendedLoggerFormatter();

  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final line = ConsoleUtils.getUnderline(
      settings.maxLineWidth,
      lineSymbol: settings.lineSymbol,
    );
    final msg = details.message?.toString() ?? '';
    if (!settings.enableColors) {
      return '$line\n$msg\n$line';
    }
    var lines = [line, ...msg.split('\n'), line];
    lines = lines.map((e) => details.pen.write(e)).toList();
    final coloredMsg = lines.join('\n');
    return coloredMsg;
  }
}
