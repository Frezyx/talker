import 'package:talker/src/utils/time_format.dart';


/// Utility class for [DateTime] formatting.
class TalkerDateTimeFormatter {
  /// Constructs a [TalkerDateTimeFormatter] with the given [date].
  const TalkerDateTimeFormatter(this.date,
      {this.timeFormat = TimeFormat.timeAndSeconds});

  /// The [DateTime] object to be formatted.
  final DateTime date;

  /// The [TimeFormat] to be used for formatting.
  final TimeFormat? timeFormat;

  /// Returns a string representation of the time and seconds.
  /// Format: ['HH:mm:s ms']
  String get timeAndSeconds {
    final d = date;
    final minutesPadded = '${d.minute}'.padLeft(2, '0');
    final secondsPadded = '${d.second}'.padLeft(2, '0');

    return '${d.hour}:$minutesPadded:$secondsPadded ${d.millisecond}ms';
  }

  /// Returns a string representation of the year, month, day, and time.
  /// Format: ['YYYY-MM-DD HH:mm:s ms']
  String get yearMonthDayAndTime =>
      '${date.year}-${date.month}-${date.day} $timeAndSeconds';

  String get format {
    switch (timeFormat) {
      case TimeFormat.timeAndSeconds:
        return timeAndSeconds;
      case TimeFormat.yearMonthDayAndTime:
        return yearMonthDayAndTime;
      case null:
        return timeAndSeconds;
    }
  }
}
