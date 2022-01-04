import 'dart:async';

import 'package:talker/talker.dart';
import 'package:talker_error_handler/talker_error_handler.dart';

class Talker implements TalkerInterface {
  Talker._() {
    _settings = kDefaultTalkerSettings;
  }

  static final _talker = Talker._();
  static Talker get instance => _talker;

  TalkerObserversManager? _observersManager;
  late TalkerSettings _settings;
  final _history = <TalkerDataInterface>[];

  late final _logger = TalkerLogger();
  late final _errorHandler = ErrorHandler()
    ..stream.listen((err) {
      TalkerDataInterface? data;
      if (err.error != null) {
        data = TalkerError(
          err.message,
          error: err.error,
          stackTrace: err.stackTrace,
          logLevel: err.errorLevel?.loglevel ?? LogLevel.error,
        );
      } else if (err.exception != null) {
        data = TalkerException(
          err.message,
          exception: err.exception,
          stackTrace: err.stackTrace,
          logLevel: err.errorLevel?.loglevel ?? LogLevel.error,
        );
      }

      if (data != null) {
        _talkerStreamController.add(data);
        _handleForHistory(data);
        _logger.log(
          data.generateTextMessage(),
          logLevel: data.logLevel ?? LogLevel.debug,
        );
      }
    });

  final _talkerStreamController =
      StreamController<TalkerDataInterface>.broadcast();

  @override
  Stream<TalkerDataInterface> get stream =>
      _talkerStreamController.stream.asBroadcastStream();

  @override
  List<TalkerDataInterface> get history => _history;

  void configure({List<TalkerObserver>? observers}) {
    if (observers != null && observers.isNotEmpty) {
      _observersManager = TalkerObserversManager(observers);
    }
  }

  @override
  void handle(ErrorContainer container) => _errorHandler.handle(container);

  @override
  void handleError(
    String msg, [
    Error? error,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]) {
    final errContainer =
        _errorHandler.handleError(msg, error, stackTrace, errorLevel);
    _observersManager?.onError(errContainer);
  }

  @override
  void handleException(
    String msg, [
    Exception? exception,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]) {
    final errContainer =
        _errorHandler.handleException(msg, exception, stackTrace, errorLevel);
    _observersManager?.onError(errContainer);
  }

  @override
  void log(
    String message,
    LogLevel logLevel, {
    Map<String, dynamic>? additional,
  }) {
    final logData = TalkerLog(
      message,
      logLevel: logLevel,
      additional: additional,
    );
    _talkerStreamController.add(logData);
    _observersManager?.onLog(logData);
    _handleForHistory(logData);
    _logger.log(
      logData.generateTextMessage(),
      logLevel: logData.logLevel ?? LogLevel.debug,
    );
  }

  void _handleForHistory(TalkerDataInterface data) {
    if (_settings.useHistory) {
      if (_settings.maxHistoryEntries <= _history.length) {
        _history.removeAt(0);
      }
      _history.add(data);
    }
  }

  @override
  void cleanHistory() {
    if (_settings.useHistory) {
      _history.clear();
    }
  }
}
