import 'package:intl/intl.dart';

/// Util for [DateTime] formating
class TalkerDateTimeFormater {
  const TalkerDateTimeFormater(this.date);

  /// Date
  final DateTime date;

  /// Get time and seconds for display in UI
  /// Format ['HH:mm:s ms']
  String get timeAndSeconds {
    return '${DateFormat('HH:mm:s ms').format(date)}ms';
  }
}
