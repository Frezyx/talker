import 'package:talker_error_handler/talker_error_handler.dart';

class HttpErrorContainer extends ErrorContainer {
  HttpErrorContainer(
    this.message, {
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
  final String message;

  @override
  final StackTrace? stackTrace;
}

void main() {
  final errorHandler = ErrorHandler(
    registeredErrors: {
      HttpErrorContainer: ErrorLevel.critical,
    },
  );

  errorHandler.stream.listen((error) {
    print('DEBUG ERROR');
    print(error.errorLevel);
  });

  errorHandler.handle(
      'Test exception', const FormatException('Test exception'));
  errorHandler.handle('Test error', ArgumentError());
}
