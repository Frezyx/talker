import 'package:talker/talker.dart';

class DartFrogLoggerFormatter implements LoggerFormatter {
  const DartFrogLoggerFormatter();

  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final msg = details.message?.toString() ?? '';
    return msg;
  }
}
