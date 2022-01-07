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
    Object? exception,
    StackTrace? stackTrace,
  });

  void critical(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  void error(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  void debug(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  void warning(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  void verbose(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  void info(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  void fine(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  void good(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  void cleanHistory();
}
