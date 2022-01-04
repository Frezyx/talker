import 'package:talker_logger/talker_logger.dart';

class TalkerLoggerSettings {
  TalkerLoggerSettings(this.errorColor);
  final Map<LogLevel, AnsiPen> errorColor;
}
