import 'dart:async';

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
  /// You can set your own [LoggerFormatter] [loggerFormatter]
  /// to format output of talker logs,
  ///
  /// You can set your own [TalkerErrorHandler] [TalkerErrorHandler]
  /// to handle talker logs errors,
  ///
  /// You can set your own [TalkerHistory] [TalkerHistory]
  /// to historize talker logs,
  ///
  /// You can add your own observer to handle errors and logs in other place
  /// [TalkerObserver] [observer],
  /// {@endtemplate}
  Talker({
    TalkerLogger? logger,
    TalkerObserver? observer,
    TalkerSettings? settings,
    TalkerFilter? filter,
    TalkerErrorHandler? errorHandler,
    TalkerHistory? history,
  }) {
    _init(filter, settings, logger, observer, errorHandler, history);
  }

  void _init(
    TalkerFilter? filter,
    TalkerSettings? settings,
    TalkerLogger? logger,
    TalkerObserver? observer,
    TalkerErrorHandler? errorHandler,
    TalkerHistory? history,
  ) {
    if (filter != null) {
      _filter = filter;
    }
    this.settings = settings ?? TalkerSettings();
    _initLogger(logger);
    _observer = observer ?? const _DefaultTalkerObserver();
    _errorHandler = errorHandler ?? TalkerErrorHandler(this.settings);
    _history = history ?? DefaultTalkerHistory(this.settings);
  }

  void _initLogger(TalkerLogger? logger) {
    _logger = logger ?? TalkerLogger();
    _logger = _logger.copyWith(
      settings: _logger.settings.copyWith(
        colors: {
          LogLevel.critical:
              settings.getAnsiPenByLogType(TalkerLogType.critical),
          LogLevel.error: settings.getAnsiPenByLogType(TalkerLogType.error),
          LogLevel.warning: settings.getAnsiPenByLogType(TalkerLogType.warning),
          LogLevel.verbose: settings.getAnsiPenByLogType(TalkerLogType.verbose),
          LogLevel.info: settings.getAnsiPenByLogType(TalkerLogType.info),
          LogLevel.debug: settings.getAnsiPenByLogType(TalkerLogType.debug),
        },
      ),
    );
  }

  /// Fields can be setup in [configure()] method
  ///
  /// {@macro talker_settings}
  late TalkerSettings settings;
  late TalkerLogger _logger;
  late TalkerErrorHandler _errorHandler;
  late TalkerFilter? _filter;
  late TalkerObserver _observer;
  late TalkerHistory _history;

  // final _fileManager = FileManager();

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
  /// You can set your own [LoggerFormatter] [loggerFormatter]
  /// to format output of talker logs,
  ///
  /// Also you can set [settings] [TalkerSettings],
  ///
  /// You can set your own [TalkerErrorHandler] [TalkerErrorHandler]
  /// to handle talker logs errors,
  ///
  /// You can set your own [TalkerHistory] [TalkerHistory]
  /// to historize talker logs,
  ///
  /// You can add your own observer to handle errors and logs in other place
  /// [TalkerObserver] [observer],
  void configure({
    TalkerLogger? logger,
    TalkerSettings? settings,
    TalkerObserver? observer,
    TalkerFilter? filter,
    TalkerErrorHandler? errorHandler,
    TalkerHistory? history,
  }) {
    _init(filter, settings, logger, observer, errorHandler, history);
  }

  final _talkerStreamController = StreamController<TalkerData>.broadcast();

  /// Common stream to sent all processed events [TalkerData]
  /// occurred errors [TalkerError]s, exceptions [TalkerException]s
  /// and logs [TalkerLog]s that have been sent
  /// You can connect a listener to it and catch the received errors
  ///
  /// Or you can add your observer [TalkerObserver] in the settings
  Stream<TalkerData> get stream =>
      _talkerStreamController.stream.asBroadcastStream();

  /// The history stores all information about all events like
  /// occurred errors [TalkerError]s, exceptions [TalkerException]s
  /// and logs [TalkerLog]s that have been sent

  List<TalkerData> get history => _history.history;

  /// Handle common exceptions in your code
  /// [Object] [exception] - exception
  /// [String?] [msg] - message describes what happened
  /// [StackTrace?] [stackTrace] - stackTrace
  ///
  /// ```dart
  /// try {
  ///   // your code...
  /// } catch (e, st) {
  ///   talker.handle(e, 'Exception in ...', st);
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
      _observer.onError(data);
      _handleErrorData(data);
      return;
    }
    if (data is TalkerException) {
      _observer.onException(data);
      _handleErrorData(data);
      return;
    }
    if (data is TalkerLog) {
      _handleLogData(data);
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
  void logTyped(TalkerLog log) {
    _handleLogData(log);
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
    _history.clean();
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
    final key = TalkerLogTypeExt.fromLogLevel(logLevel);
    final data = TalkerLog(
      message?.toString() ?? '',
      title: settings.getTitleByLogType(key),
      pen: settings.getAnsiPenByLogType(key),
      logLevel: logLevel,
    );
    _handleLogData(data);
  }

  void _handleErrorData(TalkerData data) {
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
    LogLevel? logLevel,
  }) {
    if (!settings.enabled) {
      return;
    }
    final isApproved = _isApprovedByFilter(data);
    if (!isApproved) {
      return;
    }
    final key = data.key;
    if (key != null) {
      final type = TalkerLogTypeExt.fromKey(key);
      data.title = settings.getTitleByLogType(type);
      data.pen = settings.getAnsiPenByLogType(type);
    }
    _observer.onLog(data);
    _talkerStreamController.add(data);
    _handleForOutputs(data);
    if (settings.useConsoleLogs) {
      _logger.log(
        data.generateTextMessage(),
        level: logLevel ?? data.logLevel,
        pen: data.pen,
      );
    }
  }

  void _handleForOutputs(TalkerData data) {
    _history.write(data);
  }

  //TODO: recreate file manager logic
  // void _writeToFile(TalkerDataInterface data) {
  //   if (_settings.writeToFile) {
  //     _fileManager.writeToLogFile(data.generateTextMessage());
  //   }
  // }

  bool _isApprovedByFilter(TalkerData data) {
    final approved = _filter?.filter(data) ?? true;
    return approved;
  }
}

class _DefaultTalkerObserver extends TalkerObserver {
  const _DefaultTalkerObserver();
}
