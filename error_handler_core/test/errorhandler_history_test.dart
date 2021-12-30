import 'dart:async';

import 'package:error_handler_core/error_handler_core.dart';
import 'package:test/test.dart';

void main() {
  const testExceptionMsg = 'test_exception';
  const testExceptionMsg2 = 'test_exception2';
  group('ErrorHandler_History', () {
    late ErrorHandler errorHandler;

    setUp(() => errorHandler = ErrorHandler());

    test('Long history', () {
      for (var i = 0; i < 100; i++) {
        _handleException(errorHandler, testExceptionMsg);
      }

      expect(errorHandler.history, isNotNull);
      expect(errorHandler.history, isNotEmpty);
      expect(errorHandler.history.length, 100);
    });

    test('Overload', () {
      errorHandler = ErrorHandler(
        settings: const ErrorHandlerSettings(maxHistoryEntries: 1),
      );

      errorHandler
        ..handleException(testExceptionMsg, DeferredLoadException(''))
        ..handleException(testExceptionMsg2, Exception(''));

      expect(errorHandler.history, isNotNull);
      expect(errorHandler.history, isNotEmpty);
      expect(errorHandler.history.length, 1);
      expect(errorHandler.history.first.message, testExceptionMsg2);
    });
  });
}

void _handleException(ErrorHandler errorHandler, String testExceptionMsg) {
  errorHandler.handleException(testExceptionMsg, Exception(testExceptionMsg));
}
