import 'package:talker_error_handler/talker_error_handler.dart';

class HttpException implements Exception {}

void main() {
  final errorHandler = ErrorHandler(
    registeredErrors: {
      HttpException: ErrorLevel.critical,
    },
  );

  errorHandler.stream.debug.listen((error) {
    print('DEBUG ERROR');
    print(error.errorLevel);
  });

  errorHandler.stream.critical.listen((error) {
    print('CRITICAl ERROR');
    print(error.errorLevel);
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
