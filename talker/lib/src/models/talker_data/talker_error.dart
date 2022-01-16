import 'package:talker/talker.dart';

class TalkerError implements TalkerDataInterface {
  TalkerError(
    this.error, {
    this.message,
    this.logLevel,
    this.stackTrace,
    DateTime? time,
  }) {
    _time = time ?? DateTime.now();
  }

  @override
  final Error error;

  @override
  final String? message;

  @override
  final Exception? exception = null;

  @override
  final StackTrace? stackTrace;

  @override
  final Map<String, dynamic>? additional = null;

  @override
  final LogLevel? logLevel;

  @override
  String generateTextMessage() {
    return '$displayTitle$displayMessage$displayError$displayStackTrace';
  }

  @override
  DateTime get time => _time;

  late DateTime _time;
}
