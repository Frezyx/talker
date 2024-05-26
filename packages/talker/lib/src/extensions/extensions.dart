import 'package:talker/src/utils/time_format.dart';
import 'package:talker/talker.dart';

extension TalkerDataInterfaceListExt on List<TalkerData> {
  /// The method allows you to get
  /// full text of logs or history
  String text({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    final sb = StringBuffer();
    for (final data in this) {
      sb.write('${data.generateTextMessage(timeFormat: timeFormat)}\n');
    }
    return sb.toString();
  }
}
