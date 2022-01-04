import 'package:talker/talker.dart';

class TalkerError implements TalkerDataInterface {
  TalkerError(
    this.message, {
    this.logLevel,
    this.error,
    this.stackTrace,
    DateTime? time,
  }) {
    _time = time ?? DateTime.now();
  }

  @override
  final String message;

  @override
  final Exception? exception = null;

  @override
  final Error? error;

  @override
  final StackTrace? stackTrace;

  @override
  final Map<String, dynamic>? additional = null;

  @override
  final LogLevel? logLevel;

  @override
  String generateTextMessage() {
    final m = '${getTitleText()} ';
    return '$m$message\nError: $error\nStackTrace:\n$stackTrace';
  }

  @override
  DateTime get time => _time;

  late DateTime _time;
}
