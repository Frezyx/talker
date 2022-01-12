import 'package:talker_logger/talker_logger.dart';

abstract class ConsoleFormater {
  ConsoleFormater._();

  static String getUnderline(
    int length,
    AnsiPen pen, {
    String lineSymbol = '-',
  }) {
    return pen.write(lineSymbol * length);
  }
}
