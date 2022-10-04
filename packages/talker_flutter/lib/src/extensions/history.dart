import 'package:talker_flutter/talker_flutter.dart';

extension HistoryListFlutterText on List<TalkerDataInterface> {
  /// The method allows you to get
  /// full text of logs or history
  String get flutterText {
    final sb = StringBuffer();
    for (final data in this) {
      final text = data is FlutterTalkerDataInterface
          ? data.generateFlutterTextMessage()
          : data.generateTextMessage();
      sb.write('$text\n');
      sb.write(ConsoleUtils.getUnderline(30));
    }
    return sb.toString();
  }
}
