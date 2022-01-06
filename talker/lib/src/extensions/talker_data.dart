import 'package:talker/src/src.dart';

extension HistoryListText on List<TalkerDataInterface> {
  String get text {
    final sb = StringBuffer();
    for (final data in this) {
      sb.write('${data.generateTextMessage()}\n');
    }
    return sb.toString();
  }
}
