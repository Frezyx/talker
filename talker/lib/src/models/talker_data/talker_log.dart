import 'package:talker/talker.dart';

class TalkerLog implements TalkerDataInterface {
  TalkerLog(
    this.message, {
    this.logLevel,
    this.exception,
    this.error,
    this.stackTrace,
    this.additional,
    DateTime? time,
  }) {
    _time = time ?? DateTime.now();
  }

  @override
  final String message;

  @override
  final Exception? exception;

  @override
  final Error? error;

  @override
  final StackTrace? stackTrace;

  @override
  final Map<String, dynamic>? additional;

  @override
  final LogLevel? logLevel;

  @override
  String generateTextMessage() {
    return '$titleText$message$consoleAditional';
  }

  @override
  DateTime get time => _time;

  late DateTime _time;
}
