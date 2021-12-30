export 'base_error_container.dart';

abstract class ErrorContainer {
  String? get message;
  Exception? get exception;
  Error? get error;
  StackTrace? get stackTrace;
}
