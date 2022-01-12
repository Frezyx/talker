import 'package:talker_logger/talker_logger.dart';

abstract class TalkerLoggerInterface {
  void log(String msg, {LogLevel? level, AnsiPen? pen});

  void critical(String msg);
  void error(String msg);
  void debug(String msg);
  void warning(String msg);
  void verbose(String msg);
  void info(String msg);
  void fine(String msg);
  void good(String msg);
}
