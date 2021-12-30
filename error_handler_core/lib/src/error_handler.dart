import 'dart:async';

import 'package:error_handler_core/error_handler_core.dart';

class ErrorHandler implements ErrorHandlerInterface {
  ErrorHandler({
    this.settings = kDefaultErrorHandlerSettings,
  });

  final ErrorHandlerSettings settings;

  final _controller = StreamController<ErrorContainer>();
  final _history = <ErrorContainer>[];

  @override
  Stream<ErrorContainer> get stream => _controller.stream.asBroadcastStream();

  @override
  List<ErrorContainer> get history => _history;

  @override
  void handle(
    String? message, {
    Exception? exception,
    Error? error,
    StackTrace? stackTrace,
  }) {
    _handle(
      BaseErrorContainer(
        message: message,
        error: error,
        exception: exception,
        stackTrace: stackTrace,
      ),
    );
  }

  @override
  void handleError(
    String msg, [
    Error? error,
    StackTrace? stackTrace,
  ]) {
    final container = BaseErrorContainer(
      message: msg,
      error: error,
      stackTrace: stackTrace,
    );
    _handle(container);
  }

  @override
  void handleException(
    String msg, [
    Exception? exception,
    StackTrace? stackTrace,
  ]) {
    final container = BaseErrorContainer(
      message: msg,
      exception: exception,
      stackTrace: stackTrace,
    );
    _handle(container);
  }

  void _handle(ErrorContainer container) {
    _controller.add(container);
    _handleForHistory(container);
  }

  void _handleForHistory(ErrorContainer container) {
    if (settings.useHistory) {
      _history.add(container);
      if (settings.maxHistoryEntries <= _history.length) {
        _history.removeAt(0);
      }
    }
  }
}
