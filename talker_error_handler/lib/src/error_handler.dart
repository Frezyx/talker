import 'dart:async';

import 'package:talker_error_handler/talker_error_handler.dart';

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
  ErrorContainer handleError(
    String msg, [
    Error? error,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]) {
    final container = BaseErrorContainer(
      msg,
      error: error,
      stackTrace: stackTrace,
      errorLevel: errorLevel,
    );
    _handle(container);
    return container;
  }

  @override
  ErrorContainer handleException(
    String msg, [
    Exception? exception,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]) {
    final container = BaseErrorContainer(
      msg,
      exception: exception,
      stackTrace: stackTrace,
      errorLevel: errorLevel,
    );
    _handle(container);
    return container;
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
