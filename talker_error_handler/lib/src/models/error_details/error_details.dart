//TODO: Container or wrapper
import 'package:talker_error_handler/talker_error_handler.dart';

export 'base_error_details.dart';

abstract class ErrorDetails {
  String? get message;
  Exception? get exception;
  Error? get error;
  StackTrace? get stackTrace;
  ErrorLevel? get errorLevel;
  set errorLevel(ErrorLevel? lvl);
}
