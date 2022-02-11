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
    String? msg,
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
    Object exception, [
    String? msg,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]) {
    if (exception is Exception) {
      return handleException(exception, msg, stackTrace, errorLevel);
    } else if (exception is Error) {
      return handleError(exception, msg, stackTrace, errorLevel);
    } else {
      onUnknownErrorType?.call(msg, exception, stackTrace, errorLevel);
      return null;
    }
  }

  @override
  ErrorDetails handleError(
    Error error, [
    String? msg,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]) {
    final container = BaseErrorDetails(
      message: msg,
      error: error,
      stackTrace: stackTrace,
      errorLevel: errorLevel,
    );
    _handle(container);
    return container;
  }

  @override
  ErrorDetails handleException(
    Exception exception, [
    String? msg,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  ]) {
    final container = BaseErrorDetails(
      message: msg,
      exception: exception,
      stackTrace: stackTrace,
      errorLevel: errorLevel,
    );
    _handle(container);
    return container;
  }

  void _handle(ErrorDetails details) {
    //TODO: fix type checking
    if (details.errorLevel == null) {
      final detailsLvl = _registeredErrors[details.runtimeType];
      final errLevel = _registeredErrors[details.error.runtimeType];
      final exceptionLevel = _registeredErrors[details.exception.runtimeType];
      details.errorLevel = exceptionLevel ?? errLevel ?? detailsLvl;
    }

    _controller.add(details);
    _handleForHistory(details);
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
