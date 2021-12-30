import 'package:error_handler_core/error_handler_core.dart';

abstract class ErrorHandlerInterface {
  Stream<ErrorContainer> get stream;
  List<ErrorContainer> get history;

  void handle(
    String? message, {
    Exception? exception,
    Error? error,
    StackTrace? stackTrace,
  });

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
