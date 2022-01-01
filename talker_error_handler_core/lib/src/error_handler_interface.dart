import 'package:talker_error_handler_core/talker_error_handler_core.dart';

abstract class ErrorHandlerInterface {
  Stream<ErrorContainer> get stream;
  List<ErrorContainer> get history;

  void handle(ErrorContainer container);

  void handleError(
    String msg, [
    Error? error,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]);

  void handleException(
    String msg, [
    Exception? exception,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]);
}
