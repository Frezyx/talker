import 'package:error_handler_core/src/models/error_container/error_container.dart';

class BaseErrorContainer implements ErrorContainer {
  const BaseErrorContainer({
    this.message,
    this.exception,
    this.error,
    this.stackTrace,
  });

  @override
  final String? message;

  @override
  final Exception? exception;

  @override
  final Error? error;

  @override
  final StackTrace? stackTrace;
}
