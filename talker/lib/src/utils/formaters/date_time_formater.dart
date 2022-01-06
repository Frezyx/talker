import 'package:intl/intl.dart';

class TalkerDateTimeFormater {
  const TalkerDateTimeFormater(this.date);
  final DateTime date;

  String get timeAndSeconds {
    return '${DateFormat('HH:mm:s ms').format(date)}ms';
  }
}
