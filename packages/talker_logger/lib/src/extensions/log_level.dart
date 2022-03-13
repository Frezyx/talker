import 'package:talker_logger/talker_logger.dart';

extension ToConsoleColor on LogLevel? {
  AnsiPen get consoleColor {
    switch (this) {
      case LogLevel.error:
        return AnsiPen()..red();
      case LogLevel.debug:
        return AnsiPen()..gray();
      case LogLevel.critical:
        return AnsiPen()..red();
      case LogLevel.warning:
        return AnsiPen()..yellow();
      case LogLevel.verbose:
        return AnsiPen()..yellow();
      case LogLevel.info:
        return AnsiPen()..blue();
      case LogLevel.fine:
        return AnsiPen()..cyan();
      case LogLevel.good:
        return AnsiPen()..green();
      default:
        return AnsiPen()..white();
    }
  }
}
