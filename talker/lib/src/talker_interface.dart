import 'package:talker/talker.dart';
import 'package:talker_error_handler/talker_error_handler.dart';

abstract class TalkerInterface {
  Stream<TalkerDataInterface> get stream;
  List<TalkerDataInterface> get history;
  // void handle(ErrorContainer container);

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

  void log(
    String message,
    LogLevel logLevel, {
    Map<String, dynamic>? additional,
  });

  void cleanHistory();
}
