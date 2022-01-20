import 'dart:async';

import 'package:talker/talker.dart';

class Talker implements TalkerInterface {
  Talker._() {
    _settings = kDefaultTalkerSettings;
    _logger = TalkerLogger();
    _errorHandler = ErrorHandler()
      ..stream.listen((details) {
        _handleErrorStream(details);
      });
  }

  static final _talker = Talker._();
  static TalkerInterface get instance => _talker;

  /// Fields can be setup in [configure()] method
  late TalkerSettings _settings;
  late TalkerLogger _logger;
  late ErrorHandler _errorHandler;

  // final _fileManager = FileManager();
  final _history = <TalkerDataInterface>[];
  TalkerObserversManager? _observersManager;

  /// {@macro talker_configure}
  @override
  Future<void> configure({
    TalkerLogger? logger,
    ErrorHandler? errorHandler,
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

    if (errorHandler != null) {
      _errorHandler = errorHandler
        ..stream.listen((details) {
          _handleErrorStream(details);
        });
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
    String? msg,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]) {
    final details = _errorHandler.handle(
      exception,
      msg,
      stackTrace,
      errorLevel,
    );
    if (details != null) {
      _observersManager?.onError(details);
    }
  }

  /// {@macro talker_handleError}
  @override
  void handleError(
    Error error, [
    String? msg,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]) {
    final errContainer =
        _errorHandler.handleError(error, msg, stackTrace, errorLevel);
    _observersManager?.onError(errContainer);
  }

  /// {@macro talker_handleException}
  @override
  void handleException(
    Exception exception, [
    String? msg,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]) {
    final errContainer =
        _errorHandler.handleException(exception, msg, stackTrace, errorLevel);
    _observersManager?.onError(errContainer);
  }

  /// {@macro talker_log}
  @override
  void log(
    String message, {
    LogLevel logLevel = LogLevel.debug,
    Map<String, dynamic>? additional,
    Object? exception,
    StackTrace? stackTrace,
    AnsiPen? pen,
  }) {
    _handleLog(
      exception,
      message,
      stackTrace,
      logLevel,
      additional: additional,
      pen: pen,
    );
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
    _handleLog(exception, msg, stackTrace, LogLevel.critical);
  }

  /// {@macro talker_debug_log}
  @override
  void debug(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(exception, msg, stackTrace, LogLevel.debug);
  }

  /// {@macro talker_error_log}
  @override
  void error(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(exception, msg, stackTrace, LogLevel.error);
  }

  /// {@macro talker_fine_log}
  @override
  void fine(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(exception, msg, stackTrace, LogLevel.fine);
  }

  /// {@macro talker_good_log}
  @override
  void good(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(exception, msg, stackTrace, LogLevel.good);
  }

  /// {@macro talker_info_log}
  @override
  void info(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(exception, msg, stackTrace, LogLevel.info);
  }

  /// {@macro talker_verbose_log}
  @override
  void verbose(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(exception, msg, stackTrace, LogLevel.verbose);
  }

  /// {@macro talker_warning_log}
  @override
  void warning(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
  ]) {
    _handleLog(exception, msg, stackTrace, LogLevel.warning);
  }

  ///{@macro talker_clear_log_history}
  @override
  void cleanHistory() {
    if (_settings.useHistory) {
      _history.clear();
    }
  }

  void _handleLog(
    Object? exception,
    String message,
    StackTrace? stackTrace,
    LogLevel logLevel, {
    Map<String, dynamic>? additional,
    AnsiPen? pen,
  }) {
    TalkerDataInterface? data;

    if (exception != null) {
      handle(exception, message, stackTrace);
      return;
    }

    data = TalkerLog(
      message,
      logLevel: logLevel,
      additional: additional,
    );

    _handleLogData(data as TalkerLog, pen: pen);
  }

  void _handleLogData(
    TalkerLog data, {
    AnsiPen? pen,
    LogLevel? logLevel,
  }) {
    _talkerStreamController.add(data);
    _observersManager?.onLog(data);
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
    if (_settings.useHistory) {
      _writeToHistory(data);
    }
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

  void _handleErrorStream(ErrorDetails details) {
    TalkerDataInterface? data;
    final err = details.error;
    final exception = details.exception;
    if (err != null) {
      data = TalkerError(
        err,
        message: details.message,
        stackTrace: details.stackTrace,
        logLevel: details.errorLevel?.loglevel ?? LogLevel.error,
      );
    } else if (exception != null) {
      data = TalkerException(
        exception,
        message: details.message,
        stackTrace: details.stackTrace,
        logLevel: details.errorLevel?.loglevel ?? LogLevel.error,
      );
    }

    if (data != null) {
      _talkerStreamController.add(data);
      _handleForOutputs(data);
      if (_settings.useConsoleLogs) {
        _logger.log(
          data.generateTextMessage(),
          level: data.logLevel ?? LogLevel.error,
        );
      }
    }
  }
}
