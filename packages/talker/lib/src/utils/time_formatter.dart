/// Util for [DateTime] formatting
class TalkerDateTimeFormatter {
  const TalkerDateTimeFormatter(this.date);

  /// Date
  final DateTime date;

  /// Get time and seconds for display in UI
  /// Format ['HH:mm:s ms']
  String get timeAndSeconds {
    final d = date;
    final minutesPadded = '${d.minute}'.padLeft(2, '0');
    final secondsPadded = '${d.second}'.padLeft(2, '0');

    return '${d.hour}:$minutesPadded:$secondsPadded ${d.millisecond}ms';
  }
}
