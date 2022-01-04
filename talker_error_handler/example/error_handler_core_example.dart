import 'dart:developer';

import 'package:talker_error_handler/talker_error_handler.dart';

class HttpException implements Exception {}

void main() {
  final errorHandler = ErrorHandler(
    registeredErrors: {
      HttpException: ErrorLevel.critical,
    },
  );

  errorHandler.stream.debug.listen((error) {
    log('DEBUG ERROR');
    log(error.errorLevel.toString());
  });

  errorHandler.stream.critical.listen((error) {
    log('CRITICAl ERROR');
    log(error.errorLevel.toString());
  });

  errorHandler
    ..handle(
      'Test custom exception',
      HttpException(),
    )
    ..handle(
      'Test error',
      ArgumentError(),
    )
    ..handle(
      'Test critical exception',
      Exception(),
      null,
      ErrorLevel.critical,
    );
}
