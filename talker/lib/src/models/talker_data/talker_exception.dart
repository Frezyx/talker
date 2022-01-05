import 'package:talker/talker.dart';

class TalkerException implements TalkerDataInterface {
  TalkerException(
    this.exception, {
    this.message,
    this.logLevel,
    this.stackTrace,
    DateTime? time,
  }) {
    _time = time ?? DateTime.now();
  }

  @override
  final Exception exception;

  @override
  final String? message;

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
    final mes = '$titleText$consoleMessage$consoleException$consoleStackTrace';
    final underline = ConsoleFormater.getUnderLine(mes);
    return mes + underline;
  }

  @override
  DateTime get time => _time;

  late DateTime _time;
}
