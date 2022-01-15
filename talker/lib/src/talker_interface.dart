import 'package:talker/talker.dart';

abstract class TalkerInterface {
  Stream<TalkerDataInterface> get stream;
  List<TalkerDataInterface> get history;

  /// {@template configure}
  /// Setup configuration of Talker
  ///
  /// You can set your own [TalkerLogger] [logger] subclass
  /// (create your own class implements [TalkerLoggerInterface]),
  ///
  /// You can set your own [ErrorHansdler] [errorHandler] subclass
  /// (create your own class implements [ErrorHansdlerInterface]),
  ///
  /// Also you can set [settings] [TalkerSettings],
  ///
  /// You can add your own observers to handle errors and logs in other place
  /// [List<TalkerObserver>] [observers],
  /// {@endtemplate}
  Future<void> configure({
    TalkerSettings? settings,
    List<TalkerObserver>? observers,
  });

  /// {@template talker_handle}
  /// Handle common exceptions in your code
  /// [Object] [exception] - excption
  /// [String?] [msg] - message describes what happened
  /// [StackTrace?] [stackTrace] - stackTrace
  ///
  /// ```dart
  /// try {
  ///   // your code...
  /// } catch (e, st) {
  ///   Talker.instance.handle(e, 'Eception in ...', st);
  /// }
  /// ```
  ///
  /// {@macro errorLevel}
  /// {@endtemplate}
  void handle(
    Object exception, [
    String? msg,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]);

  /// {@template talker_handleError}
  /// Handle only Errors
  /// [Error] [error] - error
  /// [String?] [msg] - message describes what happened
  /// [StackTrace?] [stackTrace] - stackTrace
  /// ```dart
  /// try {
  ///   // your code...
  /// } on Error catch (e, st) {
  ///   Talker.instance.handleError(e, 'Error in ...', st);
  /// }
  /// ```
  /// {@macro errorLevel}
  /// {@endtemplate}
  void handleError(
    Error error, [
    String? msg,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]);

  /// {@template talker_handleError}
  /// Handle only Errors
  /// [Exception] [exception] - excption
  /// [String?] [msg] - message describes what happened
  /// [StackTrace?] [stackTrace] - stackTrace
  /// ```dart
  /// try {
  ///   // your code...
  /// } on Error catch (e, st) {
  ///   Talker.instance.handleException(e, 'Error in ...', st);
  /// }
  /// ```
  /// {@macro errorLevel}
  /// {@endtemplate}
  void handleException(
    Exception exception, [
    String? msg,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]);

  /// {@template talker_log}
  /// Log a new message with maximal customization
  /// [String] [message] - message describes what happened
  /// [LogLevel] [logLevel] - to control logging output
  /// [Object?] [exception] - excption if happines
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happines
  /// [Map<String, dynamic>?] [additional] - additional log data for
  /// your own further logic processing
  /// [AnsiPen?] [pen] - sets your own log color for console
  /// ```dart
  ///   Talker.instance.log(
  ///     'Server error',
  ///     logLevel: LogLevel.critical,
  ///     additional: {
  ///       "status": 500,
  ///       "error": "Internal Server Error",
  ///     },
  ///     exception: Exception('...'),
  ///     stackTrace: stackTrace,
  ///     pen: AnsiPen()..red(),
  ///   );
  /// ```
  /// {@endtemplate}
  void log(
    String message, {
    LogLevel logLevel = LogLevel.debug,
    Map<String, dynamic>? additional,
    Object? exception,
    StackTrace? stackTrace,
    AnsiPen? pen,
  });

  void logTyped(
    TalkerLog log, {
    LogLevel logLevel = LogLevel.debug,
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
