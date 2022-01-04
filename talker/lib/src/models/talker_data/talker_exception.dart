import 'package:talker/talker.dart';

class TalkerException implements TalkerDataInterface {
  TalkerException(
    this.message, {
    this.logLevel,
    this.exception,
    this.stackTrace,
    DateTime? time,
  }) {
    _time = time ?? DateTime.now();
  }

  @override
  final String message;

  @override
  final Exception? exception;

  @override
  final Error? error = null;

  @override
  final StackTrace? stackTrace;

  @override
  final Map<String, dynamic>? additional = null;

  @override
  final LogLevel? logLevel;

  @override
  String generateTextMessage() {
    final title = '${getTitleText()} ';
    final mes =
        '$title$message\nException: $exception\nStackTrace:\n$stackTrace';
    final underline = ConsoleFormater.getUnderLine(mes);
    return mes + underline;
  }

  @override
  DateTime get time => _time;

  late DateTime _time;
}
