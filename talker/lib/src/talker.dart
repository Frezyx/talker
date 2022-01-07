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
  static Talker get instance => _talker;

  /// Fields can be setup in [configure()] method

  late TalkerSettings _settings;
  late TalkerLogger _logger;
  late ErrorHandler _errorHandler;

  // final _fileManager = FileManager();
  final _history = <TalkerDataInterface>[];
  TalkerObserversManager? _observersManager;

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

  @override
  Stream<TalkerDataInterface> get stream =>
      _talkerStreamController.stream.asBroadcastStream();

  @override
  List<TalkerDataInterface> get history => _history;

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

  @override
  void log(
    String message, {
    LogLevel logLevel = LogLevel.debug,
    Map<String, dynamic>? additional,
  }) {
    final logData = TalkerLog(
      message,
      logLevel: logLevel,
      additional: additional,
    );
    _talkerStreamController.add(logData);
    _observersManager?.onLog(logData);
    _handleForOutputs(logData);
    _logger.log(
      logData.generateTextMessage(),
      level: logData.logLevel,
    );
  }

  @override
  void cleanHistory() {
    if (_settings.useHistory) {
      _history.clear();
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
      _logger.log(
        data.generateTextMessage(),
        level: data.logLevel ?? LogLevel.debug,
      );
    }
  }
}
