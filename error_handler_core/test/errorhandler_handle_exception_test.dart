import 'dart:async';

import 'package:error_handler_core/error_handler_core.dart';
import 'package:test/test.dart';

void main() {
  const testExceptionMsg = 'test_exception';
  const testExceptionMsg2 = 'test_exception2';
  group('ErrorHandler_Handle_Exceptions', () {
    late ErrorHandler errorHandler;

    setUp(() {
      errorHandler = ErrorHandler();
    });

    test('Handle_Exception', () {
      errorHandler.handle(
        testExceptionMsg,
        exception: DeferredLoadException(''),
      );
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
        ..handle(
          testExceptionMsg,
          exception: DeferredLoadException(''),
        )
        ..handle(
          testExceptionMsg2,
          exception: Exception(''),
        );

      expect(errorHandler.history, isNotNull);
      expect(errorHandler.history, isNotEmpty);
      expect(errorHandler.history.length, 2);
      expect(errorHandler.history.first.message, testExceptionMsg);
      expect(errorHandler.history.last.message, testExceptionMsg2);
    });
  });
}
