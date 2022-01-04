abstract class ConsoleFormater {
  ConsoleFormater._();

  static String getUnderLine(String mes) {
    final parts = mes.split('\n');
    final haveEndSep = mes.substring(mes.length - 3, mes.length - 1) == '\n';
    parts.sort((a, b) => a.length.compareTo(b.length));
    final lineLen = parts.last.length;

    return haveEndSep ? '_' * lineLen : '\n${'_' * lineLen}';
  }
}
