import 'package:talker/talker.dart';

class TalkerException implements TalkerDataInterface {
  TalkerException(
    this.message, {
    this.logLevel,
    this.exception,
    // this.error,
    this.stackTrace,
    // this.additional,
  });

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
}
