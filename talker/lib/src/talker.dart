import 'dart:async';

import 'package:talker/talker.dart';

class Talker implements TalkerInterface {
  Talker._() {
    _settings = kDefaultTalkerSettings;
    _logger = TalkerLogger();
    _errorHandler = TalkerErrorHandler(_settings);
  }

  static final _talker = Talker._();
  static TalkerInterface get instance => _talker;

  /// Fields can be setup in [configure()] method
  late TalkerSettings _settings;
  late TalkerLoggerInterface _logger;
  late TalkerErrorHandlerInterface _errorHandler;

  // final _fileManager = FileManager();
  final _history = <TalkerDataInterface>[];
  TalkerObserversManager? _observersManager;

  /// {@macro talker_configure}
  @override
  Future<void> configure({
    TalkerLogger? logger,
    TalkerSettings? settings,
    List<TalkerObserver>? observers,
  }) async {
    if (settings != null) {
      _settings = settings;
    }

    if (observers != null && observers.isNotEmpty) {
      _observersManager = TalkerObserversManager(observers);
    }

    if (logger != null) {
      _logger = logger;
    }
  }

  final _talkerStreamController =
      StreamController<TalkerDataInterface>.broadcast();

  /// {@macro talker_stream}
  @override
  Stream<TalkerDataInterface> get stream =>
      _talkerStreamController.stream.asBroadcastStream();

  /// {@macro talker_history}
  @override
  List<TalkerDataInterface> get history => _history;

  /// {@macro talker_handle}
  @override
  void handle(
    Object exception, [
    StackTrace? stackTrace,
    String? msg,
    // ErrorLevel? errorLevel,
  ]) {
    final data = _errorHandler.handle(exception, stackTrace, msg);
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

  /// {@macro talker_handleError}
  @override
  void handleError(
    Error error, [
    StackTrace? stackTrace,
    String? msg,
    // ErrorLevel? errorLevel,
  ]) {
    final data = TalkerError(
      error,
      stackTrace: stackTrace,
      message: msg,
      logLevel: LogLevel.error,
    );
    _handleErrorData(data);
    _observersManager?.onError(data);
  }

  /// {@macro talker_handleException}
  @override
  void handleException(
    Exception exception, [
    StackTrace? stackTrace,
    String? msg,
    // ErrorLevel? errorLevel,
  ]) {
    final data = TalkerException(
      exception,
      stackTrace: stackTrace,
      message: msg,
      logLevel: LogLevel.error,
    );
    _handleErrorData(data);
    _observersManager?.onException(data);
  }

  /// {@macro talker_log}
  @override
  void log(
    String message, {
    LogLevel logLevel = LogLevel.debug,
    Object? exception,
    StackTrace? stackTrace,
    AnsiPen? pen,
  }) {
    _handleLog(message, exception, stackTrace, logLevel, pen: pen);
  }

  /// {@macro talker_log_typed}
  @override
  void logTyped(TalkerLog log, {LogLevel logLevel = LogLevel.debug}) {
    _handleLogData(log, logLevel: logLevel);
  }

  /// {@macro talker_critical_log}
  @override
  void critical(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(msg, exception, stackTrace, LogLevel.critical);
  }

  /// {@macro talker_debug_log}
  @override
  void debug(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(msg, exception, stackTrace, LogLevel.debug);
  }

  /// {@macro talker_error_log}
  @override
  void error(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(msg, exception, stackTrace, LogLevel.error);
  }

  /// {@macro talker_fine_log}
  @override
  void fine(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(msg, exception, stackTrace, LogLevel.fine);
  }

  /// {@macro talker_good_log}
  @override
  void good(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(msg, exception, stackTrace, LogLevel.good);
  }

  /// {@macro talker_info_log}
  @override
  void info(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(msg, exception, stackTrace, LogLevel.info);
  }

  /// {@macro talker_verbose_log}
  @override
  void verbose(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(msg, exception, stackTrace, LogLevel.verbose);
  }

  /// {@macro talker_warning_log}
  @override
  void warning(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(msg, exception, stackTrace, LogLevel.warning);
  }

  ///{@macro talker_clear_log_history}
  @override
  void cleanHistory() {
    if (_settings.useHistory) {
      _history.clear();
    }
  }

  void _handleLog(
    String message,
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

    data = TalkerLog(message, logLevel: logLevel);
    _handleLogData(data as TalkerLog, pen: pen);
  }

  void _handleErrorData(TalkerDataInterface data) {
    _talkerStreamController.add(data);
    _handleForOutputs(data);
    if (_settings.useConsoleLogs) {
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
    _observersManager?.onLog(data);

    // if (data.error != null) {
    //   handleError(data.error!);
    //   return;
    // }

    // if (data.exception != null) {
    //   handleException(data.exception!);
    //   return;
    // }

    _talkerStreamController.add(data);
    _handleForOutputs(data);
    if (_settings.useConsoleLogs) {
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
    if (_settings.useHistory) {
      if (_settings.maxHistoryItems <= _history.length) {
        _history.removeAt(0);
      }
      _history.add(data);
    }
  }
}
