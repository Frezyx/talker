abstract class ConsoleFormater {
  ConsoleFormater._();

  static String getUnderLine(String mes) {
    final parts = mes.split('\n');
    final haveEndSep = parts.last.isEmpty;
    parts.sort((a, b) => a.length.compareTo(b.length));
    final lineLen = parts.last.length;
    return haveEndSep ? '_' * lineLen : '\n${'_' * lineLen}';
  }
}
