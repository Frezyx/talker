import 'package:talker_error_handler/talker_error_handler.dart';

abstract class ErrorHandlerInterface {
  Stream<ErrorDetails> get stream;
  List<ErrorDetails> get history;

  void handle(
    Object exception, [
    String? msg,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]);

  void handleError(
    Error error, [
    String? msg,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]);

  void handleException(
    Exception exception, [
    String? msg,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]);
}
