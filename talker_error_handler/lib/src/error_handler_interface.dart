import 'package:talker_error_handler/talker_error_handler.dart';

abstract class ErrorHandlerInterface {
  Stream<ErrorDetails> get stream;
  List<ErrorDetails> get history;

  ErrorDetails? handle(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]);

  ErrorDetails handleError(
    String msg, [
    Error? error,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]);

  ErrorDetails handleException(
    String msg, [
    Exception? exception,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]);
}
