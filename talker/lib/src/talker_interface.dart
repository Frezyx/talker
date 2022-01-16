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
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
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

  /// {@template talker_log_typed}
  /// Log a new message
  /// created in the full [TalkerLog] model or they subclass
  /// (you can create it by extends of [TalkerLog])
  ///
  /// [TalkerLog] [log] - log model
  /// [LogLevel] [logLevel] - to control logging output
  /// ```dart
  /// class HttpTalkerLog extends TalkerLog {
  ///   HttpTalkerLog(String message) : super(message);
  ///
  ///   @override
  ///   AnsiPen get pen => AnsiPen()..xterm(49);
  ///
  ///   @override
  ///   String generateTextMessage() {
  ///     return pen.write(message);
  ///   }
  ///
  ///   //You can add here response model of your request
  ///   final httpLog = HttpTalkerLog('Http status: 200');
  ///   Talker.instance.logTyped(httpLog);
  /// ```
  /// {@endtemplate}
  void logTyped(
    TalkerLog log, {
    LogLevel logLevel = LogLevel.debug,
  });

  /// {@template talker_critical_log}
  /// Log a new critical message
  /// [String] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   Talker.instance.critical('Log critical');
  /// ```
  /// {@endtemplate}
  void critical(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  /// {@template talker_error_log}
  /// Log a new error message
  /// [String] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   Talker.instance.error('Log error');
  /// ```
  /// {@endtemplate}
  void error(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  /// {@template talker_debug_log}
  /// Log a new debug message
  /// [String] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   Talker.instance.debug('Log debug');
  /// ```
  /// {@endtemplate}
  void debug(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  /// {@template talker_warning_log}
  /// Log a new warning message
  /// [String] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   Talker.instance.warning('Log warning');
  /// ```
  /// {@endtemplate}
  void warning(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  /// {@template talker_verbose_log}
  /// Log a new verbose message
  /// [String] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   Talker.instance.verbose('Log verbose');
  /// ```
  /// {@endtemplate}
  void verbose(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  /// {@template talker_info_log}
  /// Log a new info message
  /// [String] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   Talker.instance.info('Log info');
  /// ```
  /// {@endtemplate}
  void info(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  /// {@template talker_fine_log}
  /// Log a new fine message
  /// [String] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   Talker.instance.fine('Log fine');
  /// ```
  /// {@endtemplate}
  void fine(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  /// {@template talker_good_log}
  /// Log a new good message
  /// [String] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   Talker.instance.good('Log good');
  /// ```
  /// {@endtemplate}
  void good(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  /// {@template talker_clear_log_history}
  /// Clear log history
  /// {@endtemplate}
  void cleanHistory();
}
