import 'dart:async';

import 'package:talker/src/utils/observers_manager.dart';
import 'package:talker/src/utils/utils.dart';
import 'package:talker/talker.dart';

/// Talker - advanced exception handling and logging
/// for dart/flutter applications
class Talker {
  /// {@template talker_constructor}
  /// Talker base constructor
  ///
  /// You can set your own [TalkerLogger] [logger] subclass
  /// (create your own class implements [TalkerLoggerInterface]),
  /// [TalkerLogger()] used by default
  ///
  /// You can edit package settings with [settings] [TalkerSettings],
  /// [TalkerSettings()] used by default
  ///
  /// You can set your own [TalkerLoggerSettings] [loggerSettings]
  /// to customize talker logs,
  ///
  /// You can set your own [LoggerFilter] [loggerFilter]
  /// to filter talker logs,
  ///
  /// You can set your own [LoggerFormater] [loggerFormater]
  /// to format output of talker logs,
  ///
  /// You can add your own observers to handle errors and logs in other place
  /// [List<TalkerObserver>] [observers],
  /// {@endtemplate}
  Talker({
    TalkerLogger? logger,
    TalkerSettings? settings,
    TalkerFilter? filter,
    TalkerLoggerSettings? loggerSettings,
    LoggerFilter? loggerFilter,
    LoggerFormatter? loggerFormater,
    List<TalkerObserver>? observers,
    Function(String message)? loggerOutput,
  }) {
    _filter = filter;
    this.settings = settings ?? TalkerSettings();
    _logger = logger ??
        TalkerLogger().copyWith(
          settings: loggerSettings,
          filter: loggerFilter,
          formater: loggerFormater,
          output: loggerOutput,
        );
    if (observers != null && observers.isNotEmpty) {
      _observersManager = TalkerObserversManager(observers);
    }
    _errorHandler = TalkerErrorHandler(this.settings);
  }

  /// Fields can be setup in [configure()] method

  /// {@macro talker_settings}
  late TalkerSettings settings;
  late TalkerLogger _logger;
  late TalkerErrorHandler _errorHandler;
  late TalkerFilter? _filter;

  // final _fileManager = FileManager();
  final _history = <TalkerDataInterface>[];
  TalkerObserversManager? _observersManager;

  /// Setup configuration of Talker
  ///
  /// You can set your own [TalkerLogger] [logger] subclass
  /// (create your own class implements [TalkerLoggerInterface]),
  ///
  /// You can set your own [TalkerLoggerSettings] [loggerSettings]
  /// to customize talker logs,
  ///
  /// You can set your own [LoggerFilter] [loggerFilter]
  /// to filter talker logs,
  ///
  /// You can set your own [LoggerFormater] [loggerFormater]
  /// to format output of talker logs,
  ///
  /// Also you can set [settings] [TalkerSettings],
  ///
  /// You can add your own observers to handle errors and logs in other place
  /// [List<TalkerObserver>] [observers],
  void configure({
    TalkerLogger? logger,
    TalkerSettings? settings,
    TalkerLoggerSettings? loggerSettings,
    LoggerFilter? loggerFilter,
    LoggerFormatter? loggerFormater,
    List<TalkerObserver>? observers,
    TalkerFilter? filter,
  }) {
    if (filter != null) {
      _filter = filter;
    }
    if (settings != null) {
      this.settings = settings;
    }

    if (observers != null && observers.isNotEmpty) {
      _observersManager = TalkerObserversManager(observers);
    }

    if (logger != null) {
      _logger = logger;
    } else {
      final currLogger = _logger;
      _logger = currLogger.copyWith(
        settings: loggerSettings,
        filter: loggerFilter,
        formater: loggerFormater,
      );
    }
  }

  final _talkerStreamController =
      StreamController<TalkerDataInterface>.broadcast();

  /// Common stream to sent all processed events [TalkerDataInterface]
  /// occurred errors [TalkerError]s, exceptions [TalkerException]s
  /// and logs [TalkerLog]s that have been sent
  /// You can connect a listener to it and catch the received errors
  ///
  /// Or you can add your observer [TalkerObserver] in the settings

  Stream<TalkerDataInterface> get stream =>
      _talkerStreamController.stream.asBroadcastStream();

  /// The history stores all information about all events like
  /// occurred errors [TalkerError]s, exceptions [TalkerException]s
  /// and logs [TalkerLog]s that have been sent

  List<TalkerDataInterface> get history => _history;

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

  void handle(
    Object exception, [
    StackTrace? stackTrace,
    dynamic msg,
  ]) {
    final data = _errorHandler.handle(exception, stackTrace, msg?.toString());
    if (data is TalkerError) {
      _observersManager?.onError(data);
      _handleErrorData(data);
      return;
    }
    if (data is TalkerException) {
      _observersManager?.onException(data);
      _handleErrorData(data);
      return;
    }
    if (data is TalkerLog) {
      _handleLogData(data);
    }
  }

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

  @Deprecated("Will be removed in a future release. Use handle method instead")
  void handleError(
    Error error, [
    StackTrace? stackTrace,
    dynamic msg,
  ]) {
    final data = TalkerError(
      error,
      stackTrace: stackTrace,
      message: msg?.toString(),
      logLevel: LogLevel.error,
    );
    _handleErrorData(data);
    if (settings.enabled) {
      _observersManager?.onError(data);
    }
  }

  /// {@macro talker_handleException}

  @Deprecated("Will be removed in a future release. Use handle method instead")
  void handleException(
    Exception exception, [
    StackTrace? stackTrace,
    dynamic msg,
    // ErrorLevel? errorLevel,
  ]) {
    final data = TalkerException(
      exception,
      stackTrace: stackTrace,
      message: msg?.toString(),
      logLevel: LogLevel.error,
    );
    _handleErrorData(data);
    if (settings.enabled) {
      _observersManager?.onException(data);
    }
  }

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

  void log(
    dynamic message, {
    LogLevel logLevel = LogLevel.debug,
    Object? exception,
    StackTrace? stackTrace,
    AnsiPen? pen,
  }) {
    _handleLog(message, exception, stackTrace, logLevel, pen: pen);
  }

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
  ///
  ///   AnsiPen get pen => AnsiPen()..xterm(49);
  ///
  ///
  ///   String generateTextMessage() {
  ///     return pen.write(message);
  ///   }
  ///
  ///   //You can add here response model of your request
  ///   final httpLog = HttpTalkerLog('Http status: 200');
  ///   talker.logTyped(httpLog);
  /// ```

  void logTyped(TalkerLog log, {LogLevel logLevel = LogLevel.debug}) {
    _handleLogData(log, logLevel: logLevel);
  }

  /// Log a new critical message
  /// [dynamic] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   talker.critical('Log critical');
  /// ```

  void critical(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(msg, exception, stackTrace, LogLevel.critical);
  }

  /// Log a new debug message
  /// [dynamic] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   talker.debug('Log debug');
  /// ```

  void debug(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(msg, exception, stackTrace, LogLevel.debug);
  }

  /// Log a new error message
  /// [dynamic] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   talker.error('Log error');
  /// ```

  void error(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(msg, exception, stackTrace, LogLevel.error);
  }

  /// Log a new fine message
  /// [dynamic] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   talker.fine('Log fine');
  /// ```

  @Deprecated("Will be removed in a future release. Use any of other LogLevel")
  void fine(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(msg, exception, stackTrace, LogLevel.fine);
  }

  /// Log a new good message
  /// [dynamic] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   talker.good('Log good');
  /// ```

  void good(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(msg, exception, stackTrace, LogLevel.good);
  }

  /// Log a new info message
  /// [dynamic] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   talker.info('Log info');
  /// ```

  void info(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(msg, exception, stackTrace, LogLevel.info);
  }

  /// Log a new verbose message
  /// [dynamic] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   talker.verbose('Log verbose');
  /// ```

  void verbose(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(msg, exception, stackTrace, LogLevel.verbose);
  }

  /// Log a new warning message
  /// [dynamic] [message] - message describes what happened
  /// [Object?] [exception] - exception if it happened
  /// [StackTrace?] [stackTrace] - stackTrace if [exception] happened
  ///
  /// ```dart
  ///   talker.warning('Log warning');
  /// ```

  void warning(
    dynamic msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(msg, exception, stackTrace, LogLevel.warning);
  }

  /// Clear log history

  void cleanHistory() {
    if (settings.useHistory) {
      _history.clear();
    }
  }

  /// Method stops all [Talker] works
  ///
  /// If you config package to handle errors or making logs,
  /// this method stop these processes

  void disable() {
    settings.enabled = false;
  }

  /// Method run all [Talker] works
  ///
  /// The method will return everything back
  /// if the package was suspended by the [disable] method

  void enable() {
    settings.enabled = true;
  }

  void _handleLog(
    dynamic message,
    Object? exception,
    StackTrace? stackTrace,
    LogLevel logLevel, {
    AnsiPen? pen,
  }) {
    TalkerDataInterface? data;
    if (exception != null) {
      handle(exception, stackTrace, message);
      return;
    }

    data = TalkerLog(message?.toString() ?? '', logLevel: logLevel);
    _handleLogData(data as TalkerLog, pen: pen);
  }

  void _handleErrorData(TalkerDataInterface data) {
    if (!settings.enabled) {
      return;
    }
    final isApproved = _isApprovedByFilter(data);
    if (!isApproved) {
      return;
    }
    _talkerStreamController.add(data);
    _handleForOutputs(data);
    if (settings.useConsoleLogs) {
      _logger.log(
        data.generateTextMessage(),
        level: data.logLevel ?? LogLevel.error,
      );
    }
  }

  void _handleLogData(
    TalkerLog data, {
    AnsiPen? pen,
    LogLevel? logLevel,
  }) {
    if (!settings.enabled) {
      return;
    }
    final isApproved = _isApprovedByFilter(data);
    if (!isApproved) {
      return;
    }
    _observersManager?.onLog(data);
    _talkerStreamController.add(data);
    _handleForOutputs(data);
    if (settings.useConsoleLogs) {
      _logger.log(
        data.generateTextMessage(),
        level: logLevel ?? data.logLevel,
        pen: data.pen ?? pen,
      );
    }
  }

  void _handleForOutputs(TalkerDataInterface data) {
    _writeToHistory(data);
    // _writeToFile(data);
  }

  //TODO: recreate file manager logic
  // void _writeToFile(TalkerDataInterface data) {
  //   if (_settings.writeToFile) {
  //     _fileManager.writeToLogFile(data.generateTextMessage());
  //   }
  // }

  void _writeToHistory(TalkerDataInterface data) {
    if (settings.useHistory && settings.enabled) {
      if (settings.maxHistoryItems <= _history.length) {
        _history.removeAt(0);
      }
      _history.add(data);
    }
  }

  bool _isApprovedByFilter(TalkerDataInterface data) {
    final approved = _filter?.filter(data) ?? true;
    return approved;
  }
}
