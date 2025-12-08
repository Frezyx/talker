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
  /// to store talker logs history,
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
    _filter = filter ?? _DefaultTalkerFilter();
    this.settings = settings ?? TalkerSettings();
    _initLogger(logger);
    _observer = observer ?? const _DefaultTalkerObserver();
    _errorHandler = errorHandler ?? TalkerErrorHandler(this.settings);
    _history = history ?? DefaultTalkerHistory(this.settings);
    _historyFilter = _logger.filter;
  }

  void _initLogger(TalkerLogger? logger) {
    _logger = logger ?? TalkerLogger();
    _logger = _logger.copyWith(
      settings: _logger.settings.copyWith(
        colors: {
          LogLevel.critical: settings.getPenByKey(TalkerKey.critical),
          LogLevel.error: settings.getPenByKey(TalkerKey.error),
          LogLevel.warning: settings.getPenByKey(TalkerKey.warning),
          LogLevel.verbose: settings.getPenByKey(TalkerKey.verbose),
          LogLevel.info: settings.getPenByKey(TalkerKey.info),
          LogLevel.debug: settings.getPenByKey(TalkerKey.debug),
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
  late TalkerFilter _filter;
  late TalkerObserver _observer;
  late TalkerHistory _history;
  late LoggerFilter _historyFilter;

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
  /// to store talker logs history,
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
    if (filter != null) {
      _filter = filter;
    }
    if (settings != null) {
      this.settings = settings;
    }
    _observer = observer ?? _observer;
    _logger = logger ?? _logger;
    _errorHandler = errorHandler ?? TalkerErrorHandler(this.settings);
    _history = DefaultTalkerHistory(this.settings, history: _history.history);
    _historyFilter = _logger.filter;
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

  /// [TalkerFilter] [filter] - filter for selecting specific logs and errors
  /// by their keys [TalkerData.key] and by string query [TalkerFilter.searchQuery]
  /// You can set it in [configure] method
  /// or change it later
  TalkerFilter get filter => _filter;

  /// Handle common exceptions in your code
  /// [Object] [exception] - exception
  /// [StackTrace?] [stackTrace] - stackTrace
  /// [String?] [msg] - message describes what happened
  ///
  /// ```dart
  /// try {
  ///   // your code...
  /// } catch (e, st) {
  ///   talker.handle(e, st, 'Exception in ...');
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
      _handleErrorData(data);
      return;
    }
    if (data is TalkerException) {
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

  /// {@macro logCustom}
  @Deprecated(
    'Use logCustom instead. '
    'This feature was deprecated after v4.5.0',
  )
  void logTyped(TalkerLog log) => logCustom(log);

  /// {@template logCustom}
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
  ///   talker.logCustom(httpLog);
  /// ```
  /// {@endtemplate}
  void logCustom(TalkerLog log) => _handleLogData(log);

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
  void cleanHistory() => _history.clean();

  /// Method run all [Talker] works
  ///
  /// The method will return everything back
  /// if the package was suspended by the [disable] method
  void enable() => settings.enabled = true;

  /// Method stops all [Talker] works
  ///
  /// If you config package to handle errors or making logs,
  /// this method stop these processes
  void disable() => settings.enabled = false;

  void _handleLog(
    dynamic message,
    Object? exception,
    StackTrace? stackTrace,
    LogLevel logLevel, {
    AnsiPen? pen,
  }) {
    final key = TalkerKey.fromLogLevel(logLevel);
    final penByLogKey = settings.getPenByKey(key);
    final title = settings.getTitleByKey(key);
    final data = TalkerLog(
      key: key,
      message?.toString() ?? '',
      title: title,
      exception: exception,
      stackTrace: stackTrace,
      pen: pen ?? penByLogKey,
      logLevel: logLevel,
    );
    _handleLogData(data);
  }

  void _handleErrorData(TalkerData data) {
    // If the Talker is disabled by settings
    if (!settings.enabled) return;

    // If the log is not approved by the filter
    final isApproved = _isApprovedByFilter(data);
    if (!isApproved) return;

    if (data is TalkerError) _observer.onError(data);
    if (data is TalkerException) _observer.onException(data);

    _talkerStreamController.add(data);
    _handleForOutputs(data);
    if (settings.useConsoleLogs) {
      _logger.log(
        data.generateTextMessage(timeFormat: settings.timeFormat),
        level: data.logLevel ?? LogLevel.error,
        pen: data.pen,
      );
    }
  }

  void _handleLogData(
    TalkerLog data, {
    LogLevel? logLevel,
  }) {
    // If the Talker is disabled by settings
    if (!settings.enabled) return;

    // If the log is not approved by the filter
    final isApproved = _isApprovedByFilter(data);
    if (!isApproved) return;

    // Log customization setup and configuration
    var pen = data.pen;
    final key = data.key;
    if (key != null) {
      data.title = settings.getTitleByKey(key);
      // Only use the key's default color if user didn't provide a custom pen
      if (pen == null) {
        pen = settings.getPenByKey(key);
        data.pen = pen;
      }
    }

    _observer.onLog(data);
    _talkerStreamController.add(data);
    _handleForOutputs(data);
    if (settings.useConsoleLogs) {
      _logger.log(
        data.generateTextMessage(timeFormat: settings.timeFormat),
        level: logLevel ?? data.logLevel,
        pen: pen,
      );
    }
  }

  void _handleForOutputs(TalkerData data) {
    if (_historyFilter.shouldLog(
        data.generateTextMessage(timeFormat: settings.timeFormat),
        data.logLevel ?? LogLevel.debug)) {
      _history.write(data);
    }
  }

  bool _isApprovedByFilter(TalkerData data) {
    final approved = _filter.filter(data);
    return approved;
  }
}

class _DefaultTalkerObserver extends TalkerObserver {
  const _DefaultTalkerObserver();
}

class _DefaultTalkerFilter extends TalkerFilter {
  @override
  bool filter(TalkerData item) => true;
}
