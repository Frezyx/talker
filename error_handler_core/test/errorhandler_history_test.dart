import 'dart:async';

import 'package:error_handler_core/error_handler_core.dart';
import 'package:test/test.dart';

void main() {
  const testExceptionMsg = 'test_exception';
  const testExceptionMsg2 = 'test_exception2';
  group('ErrorHandler_History', () {
    late ErrorHandler errorHandler;

    setUp(() => errorHandler = ErrorHandler());

    test('Overload', () {
      errorHandler = ErrorHandler(
        settings: const ErrorHandlerSettings(maxHistoryEntries: 1),
      );

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
      expect(errorHandler.history.length, 1);
      expect(errorHandler.history.first.message, testExceptionMsg2);
    });
  });
}
