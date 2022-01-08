import 'package:talker_logger/talker_logger.dart';

abstract class ConsoleFormater {
  ConsoleFormater._();

  static String addUnderline(String mes, AnsiPen pen) {
    final parts = mes.split('\n');

    final haveEndSep = parts.last.isEmpty;
    parts.sort((a, b) => a.length.compareTo(b.length));
    final lineLen = parts.last.length;

    return mes + pen.write(haveEndSep ? '_' * lineLen : '\n${'_' * lineLen}');
  }
}
