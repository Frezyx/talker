import 'package:talker/talker.dart';
import 'package:talker_error_handler_core/talker_error_handler_core.dart';

abstract class TalkerInterface {
  Stream<TalkerDataInterface> get stream;
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
