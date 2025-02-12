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

extension TalkerIterableLogTypeModifier<TalkerLogType>
    on Iterable<TalkerLogType> {
  /// The method allows you to get the first element that satisfies the condition
  /// or null if no element satisfies the condition.
  TalkerLogType? firstWhereLogTypeOrNull(
          bool Function(TalkerLogType element) test) =>
      cast<TalkerLogType?>()
          .firstWhere((v) => v != null && test(v), orElse: () => null);
}
