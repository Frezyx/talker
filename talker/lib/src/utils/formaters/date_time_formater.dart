import 'package:intl/intl.dart';

class DateTimeFormater {
  const DateTimeFormater(this.date);
  final DateTime date;

  String get timeAndSeconds {
    return '${DateFormat('HH:mm:s ms').format(date)}ms';
  }
}
