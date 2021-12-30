import 'package:error_handler_core/error_handler_core.dart';

abstract class ErrorHandlerInterface {
  Stream<ErrorContainer> get stream;

  void handle(ErrorContainer container);

  void handleError(
    String msg, [
    Error? error,
    StackTrace? stackTrace,
  ]);

  void handleException(
    String msg, [
    Exception? exception,
    StackTrace? stackTrace,
  ]);
}
