import 'package:talker/src/src.dart';

extension HistoryListText on List<TalkerDataInterface> {
  String get text {
    var m = '';
    for (final data in this) {
      m += '${data.generateTextMessage()}\n';
    }
    return m;
  }
}
