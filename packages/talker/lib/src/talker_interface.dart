import 'package:talker/talker.dart';

abstract class TalkerInterface {
  /// {@template talker_stream}
  /// Common stream to sent all processed events [TalkerDataInterface]
  /// occurred errors [TalkerError]s, exceptions [TalkerException]s
  /// and logs [TalkerLog]s that have been sent
  /// You can connect a listener to it and catch the received errors
  ///
  /// Or you can add your observer [TalkerObserver] in the settings
  /// {@endtemplate}
  Stream<TalkerDataInterface> get stream;

  /// {@template talker_history}
  /// The history stores all information about all events like
  /// occurred errors [TalkerError]s, exceptions [TalkerException]s
  /// and logs [TalkerLog]s that have been sent
  /// {@endtemplate}
  List<TalkerDataInterface> get history;

  /// {@template talker_configure}
  /// Setup configuration of Talker
  ///
  /// You can set your own [TalkerLogger] [logger] subclass
  /// (create your own class implements [TalkerLoggerInterface]),
  ///
  /// You can set your own [TalkerLoggerSettings] [loggerSettings]
  /// to customize talker logs,
  ///
  /// You can set your own [TalkerLoggerFilter] [loggerFilter]
  /// to filter talker logs,
  ///
  /// You can set your own [LoggerFormater] [loggerFormater]
  /// to format output of talker logs,
  ///
  /// Also you can set [settings] [TalkerSettings],
  ///
  /// You can add your own observers to handle errors and logs in other place
  /// [List<TalkerObserver>] [observers],
  /// {@endtemplate}
  void configure({
    TalkerSettings? settings,
    TalkerLogger? logger,
    TalkerLoggerSettings? loggerSettings,
    TalkerLoggerFilter? loggerFilter,
    LoggerFormatter? loggerFormater,
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
  ///   talker.handle(e, 'Eception in ...', st);
  /// }
  /// ```
  ///
  /// {@macro errorLevel}
  /// {@endtemplate}
  void handle(
    Object exception, [
    StackTrace? stackTrace,
    dynamic msg,
    // ErrorLevel? errorLevel,
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
  ///   talker.handleError(e, 'Error in ...', st);
  /// }
  /// ```
  /// {@macro errorLevel}
  /// {@endtemplate}
  @Deprecated("Will be removed in a future release. Use handle method instead")
  void handleError(
    Error error, [
    StackTrace? stackTrace,
    dynamic msg,
    // ErrorLevel? errorLevel,
  ]);

  /// {@template talker_handleError}
  /// Handle only Exceptions
  /// [Exception] [exception] - excption
  /// [String?] [msg] - message describes what happened
  /// [StackTrace?] [stackTrace] - stackTrace
  /// ```dart
  /// try {
  ///   // your code...
  /// } on Exception catch (e, st) {
  ///   talker.handleException(e, 'Exception in ...', st);
  /// }
  /// ```
  /// {@macro errorLevel}
  /// {@endtemplate}
  @Deprecated("Will be removed in a future release. Use handle method instead")
  void handleException(
    Exception exception, [
    StackTrace? stackTrace,
    dynamic msg,
    // ErrorLevel? errorLevel,
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
  ///   talker.log(
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
    dynamic message, {
    LogLevel logLevel = LogLevel.debug,
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
  ///   talker.logTyped(httpLog);
  /// ```
  /// {@endtemplate}
  void logTyped(
    TalkerLog log, {
    LogLevel logLevel = LogLevel.debug,
  });

  /// {@template talker_critical_log}
  /// Log a new critical message
  /// [dynamic] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   talker.critical('Log critical');
  /// ```
  /// {@endtemplate}
  void critical(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  /// {@template talker_error_log}
  /// Log a new error message
  /// [dynamic] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   talker.error('Log error');
  /// ```
  /// {@endtemplate}
  void error(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  /// {@template talker_debug_log}
  /// Log a new debug message
  /// [dynamic] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   talker.debug('Log debug');
  /// ```
  /// {@endtemplate}
  void debug(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  /// {@template talker_warning_log}
  /// Log a new warning message
  /// [dynamic] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   talker.warning('Log warning');
  /// ```
  /// {@endtemplate}
  void warning(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  /// {@template talker_verbose_log}
  /// Log a new verbose message
  /// [dynamic] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   talker.verbose('Log verbose');
  /// ```
  /// {@endtemplate}
  void verbose(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  /// {@template talker_info_log}
  /// Log a new info message
  /// [dynamic] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   talker.info('Log info');
  /// ```
  /// {@endtemplate}
  void info(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  /// {@template talker_fine_log}
  /// Log a new fine message
  /// [dynamic] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   talker.fine('Log fine');
  /// ```
  /// {@endtemplate}
  void fine(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  /// {@template talker_good_log}
  /// Log a new good message
  /// [dynamic] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   talker.good('Log good');
  /// ```
  /// {@endtemplate}
  void good(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]);

  /// {@template talker_clear_log_history}
  /// Clear log history
  /// {@endtemplate}
  void cleanHistory();

  /// {@template talker_disable}
  /// Method stops all [Talker] works
  ///
  /// If you config package to handle errors or making logs,
  /// this method stop these processes
  /// {@endtemplate}
  void disable();

  /// {@template talker_enable}
  /// Method run all [Talker] works
  ///
  /// The method will return everything back
  /// if the package was suspended by the [disable] method
  /// {@endtemplate}
  void enable();

  /// {@macro talker_settings}
  TalkerSettings get settings;

  /// {@macro talker_settings}
  set settings(TalkerSettings val);

  /// {@template talker_addons}
  /// [Talker] additional package instances for
  /// setup settings and updating mutual functionality
  ///
  /// {@endtemplate}
  Map<String, Object> get addons;

  /// {@template talker_addons_register}
  /// Method to setup new addon
  /// {@endtemplate}
  void registerAddon({required String code, required Object addon});

  /// {@template talker_addons_reset}
  /// Method to remove addon from registerd
  /// {@endtemplate}
  void resetAddon(String code);
}
