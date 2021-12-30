import 'package:error_handler_core/error_handler_core.dart';

abstract class ErrorHandlerInterface {
  Stream<ErrorContainer> get stream;
}
