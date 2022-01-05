import 'dart:async';

import 'package:talker_error_handler/talker_error_handler.dart';
import 'package:test/test.dart';

void main() {
  const testExceptionMsg = 'test_exception';
  const testExceptionMsg2 = 'test_exception2';
  group('ErrorHandler_Handle_Exceptions', () {
    late ErrorHandler errorHandler;

    setUp(() => errorHandler = ErrorHandler());

    test('Handle_Exception', () {
      errorHandler.handleException(DeferredLoadException(''), testExceptionMsg);
      errorHandler.stream.listen((lastControllerValue) {
        expect(lastControllerValue, isNotNull);
        expect(lastControllerValue.message, testExceptionMsg);
        expect(
          lastControllerValue.exception.runtimeType,
          DeferredLoadException,
        );
      });
    });

    test('Handle_MultiplyExceptions_Timings', () {
      errorHandler
        ..handleException(DeferredLoadException(''), testExceptionMsg)
        ..handleException(Exception(''), testExceptionMsg2);

      expect(errorHandler.history, isNotNull);
      expect(errorHandler.history, isNotEmpty);
      expect(errorHandler.history.length, 2);
      expect(errorHandler.history.first.message, testExceptionMsg);
      expect(errorHandler.history.last.message, testExceptionMsg2);
    });
  });
}
