import 'package:talker_error_handler/talker_error_handler.dart';

/// Base error container
// TODO: rename
class BaseErrorDetails implements ErrorDetails {
  BaseErrorDetails({
    this.exception,
    this.message,
    this.error,
    this.stackTrace,
    this.errorLevel,
  });

  @override
  final String? message;

  @override
  final Exception? exception;

  @override
  final Error? error;

  @override
  final StackTrace? stackTrace;

  @override
  ErrorLevel? errorLevel;

  BaseErrorDetails copyWith({
    String? message,
    Exception? exception,
    Error? error,
    StackTrace? stackTrace,
    ErrorLevel? errorLevel,
  }) {
    return BaseErrorDetails(
      message: message ?? this.message,
      exception: exception ?? this.exception,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
      errorLevel: errorLevel ?? this.errorLevel,
    );
  }
}
