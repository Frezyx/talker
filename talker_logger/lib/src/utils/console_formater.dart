import 'package:talker_logger/talker_logger.dart';

abstract class ConsoleFormater {
  ConsoleFormater._();

  static String addUnderline(
    String mes,
    AnsiPen pen, {
    String lineSymbol = '-',
  }) {
    final parts = mes.split('\n');

    final haveEndSep = parts.last.isEmpty;
    parts.sort((a, b) => a.length.compareTo(b.length));
    final lineLen = parts.last.length;

    final line = lineSymbol * lineLen;
    return mes + pen.write(haveEndSep ? line : '\n$line');
  }
}
