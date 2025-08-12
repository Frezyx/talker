import 'package:talker_flutter/talker_flutter.dart';

extension HistoryListFlutterText on List<TalkerData> {
  @Deprecated('Use getFormattedText instead')
  String get flutterText {
    final sb = StringBuffer();
    for (final data in this) {
      final text = data.generateTextMessage();
      sb.write('$text\n');
      sb.write(ConsoleUtils.getUnderline(30));
    }
    return sb.toString();
  }

  /// This method allows you to get
  /// full text of logs in history with formatting
  String getFormattedText({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    for (final data in this) {
      final text = data.generateTextMessage(timeFormat: timeFormat);
      sb.write('$text\n');
      sb.write(ConsoleUtils.getUnderline(30));
    }
    return sb.toString();
  }
}
