import 'package:talker/talker.dart';

extension TalkerDataInterfaceListExt on List<TalkerDataInterface> {
  /// The method allows you to get
  /// full text of logs or history
  String get text {
    final sb = StringBuffer();
    for (final data in this) {
      sb.write('${data.generateTextMessage()}\n');
    }
    return sb.toString();
  }
}

extension AnsiExtension on AnsiPen {
  /// Make ansi to hex f
  String toHexColor() {
    final ansiColor = fcolor != -1 ? fcolor : bcolor;

    // Extract RGB components from the ANSI color code
    int r = (((ansiColor - 16) ~/ 36) / 5 * 255).toInt();
    int g = (((ansiColor - 16) ~/ 6 % 6) / 5 * 255).toInt();
    int b = ((ansiColor - 16) % 6 / 5 * 255).toInt();

    // Convert RGB components to HEX format
    String hexColor =
        '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}';

    return hexColor;
  }
}
