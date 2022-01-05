import 'dart:async';

import 'package:talker_error_handler/talker_error_handler.dart';

class ErrorHandler implements ErrorHandlerInterface {
  ErrorHandler({
    this.settings = kDefaultErrorHandlerSettings,
    Map<Type, ErrorLevel>? registeredErrors,
    this.onUnknownErrorType,
  }) {
    _registeredErrors.addAll(kDefaultRegisteredErrors);
    if (registeredErrors != null) {
      _registeredErrors.addAll(registeredErrors);
    }
  }

  final ErrorHandlerSettings settings;
  final Map<Type, ErrorLevel> _registeredErrors = {};
  final Function(
    String msg,
    Object? exception,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  )? onUnknownErrorType;

  final _controller = StreamController<ErrorDetails>.broadcast();
  final _history = <ErrorDetails>[];

  @override
  Stream<ErrorDetails> get stream => _controller.stream.asBroadcastStream();

  @override
  List<ErrorDetails> get history => _history;

  @override
  ErrorDetails? handle(
    String msg, [
    Object? exception,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]) {
    if (exception is Exception) {
      return handleException(msg, exception, stackTrace, errorLevel);
    } else if (exception is Error) {
      return handleError(msg, exception, stackTrace, errorLevel);
    } else {
      onUnknownErrorType?.call(msg, exception, stackTrace, errorLevel);
    }
  }

  @override
  ErrorDetails handleError(
    String msg, [
    Error? error,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]) {
    final container = BaseErrorDetails(
      msg,
      error: error,
      stackTrace: stackTrace,
      errorLevel: errorLevel,
    );
    _handle(container);
    return container;
  }

  @override
  ErrorDetails handleException(
    String msg, [
    Exception? exception,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]) {
    final container = BaseErrorDetails(
      msg,
      exception: exception,
      stackTrace: stackTrace,
      errorLevel: errorLevel,
    );
    _handle(container);
    return container;
  }

  void _handle(ErrorDetails container) {
    //TODO: fix type checking
    final errLvl = _registeredErrors[container.runtimeType];
    if (errLvl != null && container.errorLevel == null) {
      container.errorLevel = errLvl;
    }
    _controller.add(container);
    _handleForHistory(container);
  }

  void _handleForHistory(ErrorDetails container) {
    if (settings.useHistory) {
      if (settings.maxHistoryEntries <= _history.length) {
        _history.removeAt(0);
      }
      _history.add(container);
    }
  }
}
