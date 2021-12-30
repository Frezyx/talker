import 'package:error_handler_core/error_handler_core.dart';

class HttpErrorContainer extends ErrorContainer {
  HttpErrorContainer({
    this.message,
    this.error,
    this.exception,
    this.stackTrace,
    this.errorLevel,
  });
  @override
  ErrorLevel? errorLevel;

  @override
  final Error? error;

  @override
  final Exception? exception;

  @override
  final String? message;

  @override
  final StackTrace? stackTrace;
}

void main() {
  final errorHandler = ErrorHandler(
    registeredErrors: {
      HttpErrorContainer: ErrorLevel.critical,
    },
  );

  errorHandler.stream.debug.listen((error) {
    print('DEBUG ERROR');
    print(error.errorLevel);
  });

  errorHandler.handle(BaseErrorContainer());
  errorHandler.handle(HttpErrorContainer());
}
