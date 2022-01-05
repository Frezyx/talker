import 'dart:async';

import 'package:talker_error_handler/talker_error_handler.dart';
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
        ..handleException(DeferredLoadException(''), testExceptionMsg)
        ..handleException(Exception(''), testExceptionMsg2);

      expect(errorHandler.history, isNotNull);
      expect(errorHandler.history, isNotEmpty);
      expect(errorHandler.history.length, 1);
      expect(errorHandler.history.first.message, testExceptionMsg2);
    });
  });
}

void _handleException(ErrorHandler errorHandler, String testExceptionMsg) {
  errorHandler.handleException(Exception(testExceptionMsg), testExceptionMsg);
}
