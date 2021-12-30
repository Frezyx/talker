//TODO: Container or wrapper
import 'package:error_handler_core/error_handler_core.dart';

export 'base_error_container.dart';

abstract class ErrorContainer {
  String? get message;
  Exception? get exception;
  Error? get error;
  StackTrace? get stackTrace;
  ErrorLevel? get errorLevel;
  set errorLevel(ErrorLevel? lvl);
}
