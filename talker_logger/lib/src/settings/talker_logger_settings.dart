import 'package:talker_logger/talker_logger.dart';

const kDefaultLoggerSettings = TalkerLoggerSettings();

class TalkerLoggerSettings {
  const TalkerLoggerSettings({this.colors = const {}});
  final Map<LogLevel, AnsiPen> colors;
}
