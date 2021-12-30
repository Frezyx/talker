import 'dart:async';

import 'package:error_handler_core/error_handler_core.dart';

class ErrorHandler implements ErrorHandlerInterface {
  final _controller = StreamController<ErrorContainer>();

  @override
  Stream<ErrorContainer> get stream => _controller.stream.asBroadcastStream();
}
