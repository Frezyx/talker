import 'package:talker/talker.dart';

abstract class TalkerInterface {
  Stream<TalkerDataInterface> get stream;
  List<TalkerDataInterface> get history;

  Future<void> configure({
    TalkerSettings? settings,
    List<TalkerObserver>? observers,
  });

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

  void log(
    String message, {
    LogLevel logLevel = LogLevel.debug,
    Map<String, dynamic>? additional,
  });

  void cleanHistory();
}
