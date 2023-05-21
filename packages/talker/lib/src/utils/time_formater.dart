/// Util for [DateTime] formating
class TalkerDateTimeFormater {
  const TalkerDateTimeFormater(this.date);

  /// Date
  final DateTime date;

  /// Get time and seconds for display in UI
  /// Format ['HH:mm:s ms']
  String get timeAndSeconds {
    final d = date;
    return '${d.hour}:${d.minute}:${d.second} ${d.millisecond}ms';
  }
}
