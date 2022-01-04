import 'package:talker/talker.dart';

class TalkerError implements TalkerDataInterface {
  TalkerError(
    this.message, {
    this.logLevel,
    // this.exception,
    this.error,
    this.stackTrace,
    // this.additional,
  });

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
    final m = '[${getTitleText()}] ';
    return '$m$message\n $error';
  }
}
