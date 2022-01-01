import 'package:talker_error_handler_core/talker_error_handler_core.dart';
import 'package:test/test.dart';

void main() {
  const testErrorMsg = 'test_error';
  const testErrorMsg2 = 'test_error2';
  group('ErrorHandler_Handle_Errors', () {
    late ErrorHandler errorHandler;

    setUp(() => errorHandler = ErrorHandler());

    test('Handle_Error', () {
      errorHandler.handleError(testErrorMsg, ArgumentError());
      errorHandler.stream.listen((lastControllerValue) {
        expect(lastControllerValue, isNotNull);
        expect(lastControllerValue.message, testErrorMsg);
        expect(lastControllerValue.error.runtimeType, ArgumentError);
      });
    });

    test('Handle_MultiplyErrors_Timings', () {
      errorHandler
        ..handleError(testErrorMsg, ArgumentError(''))
        ..handleError(testErrorMsg2, TypeError());

      expect(errorHandler.history, isNotNull);
      expect(errorHandler.history, isNotEmpty);
      expect(errorHandler.history.length, 2);
      expect(errorHandler.history.first.message, testErrorMsg);
      expect(errorHandler.history.last.message, testErrorMsg2);
    });
  });
}
