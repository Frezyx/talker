import 'package:talker/talker.dart';

class TalkerDataContainer implements TalkerDataInterface {
  TalkerDataContainer(
    this.message, {
    this.logLevel,
    this.exception,
    this.error,
    this.stackTrace,
    this.additional,
  });

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
}
