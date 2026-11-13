import 'package:talker_logger/src/logger_io.dart' as logger_io;
import 'package:test/test.dart';

void main() {
  group('outputLog', () {
    test('should output single line message', () {
      // This test verifies that outputLog can handle single line messages
      // We cannot easily capture stdout in tests, so we just verify it doesn't throw
      expect(() => logger_io.outputLog('Test message'), returnsNormally);
    });

    test('should output multi-line message', () {
      // This test verifies that outputLog can handle multi-line messages
      // Each line should be written separately
      expect(
        () => logger_io.outputLog('Line 1\nLine 2\nLine 3'),
        returnsNormally,
      );
    });

    test('should handle empty message', () {
      // This test verifies that outputLog can handle empty messages
      expect(() => logger_io.outputLog(''), returnsNormally);
    });

    test('should handle message with only newlines', () {
      // This test verifies that outputLog can handle messages with only newlines
      expect(() => logger_io.outputLog('\n\n\n'), returnsNormally);
    });
  });
}
