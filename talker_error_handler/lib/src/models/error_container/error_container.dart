//TODO: Container or wrapper
import 'package:talker_error_handler/talker_error_handler.dart';

export 'base_error_container.dart';

abstract class ErrorContainer {
  String get message;
  Exception? get exception;
  Error? get error;
  StackTrace? get stackTrace;
  ErrorLevel? get errorLevel;
  set errorLevel(ErrorLevel? lvl);
}
