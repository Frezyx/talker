/// Сlass that contains methods for working with console output
abstract class ConsoleUtils {
  ConsoleUtils._();

  /// Method returns a line for the bottom of the message
  static String getUnderline(int length, {String lineSymbol = '-'}) {
    return lineSymbol * length;
  }
}
