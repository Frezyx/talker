import 'dart:async';

import 'package:error_handler_core/error_handler_core.dart';

class ErrorHandler implements ErrorHandlerInterface {
  final _controller = StreamController<ErrorContainer>();

  @override
  Stream<ErrorContainer> get stream => _controller.stream.asBroadcastStream();

  @override
  void handle(ErrorContainer container) => _handle(container);

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

  void _handle(ErrorContainer container) {}
}
