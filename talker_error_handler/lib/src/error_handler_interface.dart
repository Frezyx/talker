import 'package:talker_error_handler/talker_error_handler.dart';

abstract class ErrorHandlerInterface {
  Stream<ErrorContainer> get stream;
  List<ErrorContainer> get history;

  void handle(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]);

  ErrorContainer handleError(
    String msg, [
    Error? error,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]);

  ErrorContainer handleException(
    String msg, [
    Exception? exception,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]);
}
