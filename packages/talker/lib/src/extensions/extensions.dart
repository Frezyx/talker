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

extension IterableModifier<E> on Iterable<E> {
  /// The method allows you to get the first element that satisfies the condition
  /// or null if no element satisfies the condition.
  E? firstWhereOrNull(bool Function(E element) test) =>
      cast<E?>().firstWhere((v) => v != null && test(v), orElse: () => null);
}
