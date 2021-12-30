export 'base_error_container.dart';

//TODO: Container or wrapper
abstract class ErrorContainer {
  String? get message;
  Exception? get exception;
  Error? get error;
  StackTrace? get stackTrace;
}
