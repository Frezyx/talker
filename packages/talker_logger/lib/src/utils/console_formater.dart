abstract class ConsoleFormater {
  ConsoleFormater._();

  static String getUnderline(
    int length, {
    String lineSymbol = '-',
  }) {
    return lineSymbol * length;
  }
}
