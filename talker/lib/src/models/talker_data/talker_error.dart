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
    final mes = '$titleText$displayMessage$displayError\n$displayStackTrace';
    return ConsoleFormater.addUnderline(mes);
  }

  @override
  DateTime get time => _time;

  late DateTime _time;
}
