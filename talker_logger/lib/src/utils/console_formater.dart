abstract class ConsoleFormater {
  ConsoleFormater._();

  static String getUnderLine(String mes) {
    final parts = mes.split('\n');
    parts.sort((a, b) => a.length.compareTo(b.length));
    final lineLen = parts.last.length;
    return '_' * lineLen;
  }
}
