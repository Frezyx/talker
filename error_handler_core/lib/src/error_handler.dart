import 'dart:async';

import 'package:error_handler_core/error_handler_core.dart';

class ErrorHandler implements ErrorHandlerInterface {
  ErrorHandler({
    this.settings = kDefaultErrorHandlerSettings,
    Map<Type, ErrorLevel>? registeredErrors,
  }) {
    _registeredErrors.addAll(kDefaultRegisteredErrors);
    if (registeredErrors != null) {
      _registeredErrors.addAll(registeredErrors);
    }
  }

  final ErrorHandlerSettings settings;
  final Map<Type, ErrorLevel> _registeredErrors = {};

  final _controller = StreamController<ErrorContainer>.broadcast();
  final _history = <ErrorContainer>[];

  @override
  Stream<ErrorContainer> get stream => _controller.stream.asBroadcastStream();

  @override
  List<ErrorContainer> get history => _history;

  @override
  void handle(ErrorContainer container) {
    final errLvl = _registeredErrors[container.runtimeType];
    if (errLvl != null && container.errorLevel == null) {
      container.errorLevel = errLvl;
    }
    _handle(container);
  }

  @override
  void handleError(
    String msg, [
    Error? error,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]) {
    final container = BaseErrorContainer(
      message: msg,
      error: error,
      stackTrace: stackTrace,
      errorLevel: errorLevel,
    );
    _handle(container);
  }

  @override
  void handleException(
    String msg, [
    Exception? exception,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]) {
    final container = BaseErrorContainer(
      message: msg,
      exception: exception,
      stackTrace: stackTrace,
      errorLevel: errorLevel,
    );
    _handle(container);
  }

  void _handle(ErrorContainer container) {
    _controller.add(container);
    _handleForHistory(container);
  }

  void _handleForHistory(ErrorContainer container) {
    if (settings.useHistory) {
      if (settings.maxHistoryEntries <= _history.length) {
        _history.removeAt(0);
      }
      _history.add(container);
    }
  }
}
