// ignore_for_file: unnecessary_type_check, leading_newlines_in_multiline_strings

import 'package:talker/talker.dart';
import 'package:test/test.dart';

const _testMessage = 'test message';
const _testTitle = 'test title';

void main() {
  group('TalkerDataInterface models', () {
    test('TalkerError', () async {
      final error = TalkerError(
        ArgumentError(),
        message: _testMessage,
        logLevel: LogLevel.critical,
        stackTrace: StackTrace.empty,
        title: _testTitle,
      );

      expect(error is TalkerDataInterface, true);
      expect(error is TalkerError, true);
      expect(error.message, _testMessage);
      expect(error.title, _testTitle);
      expect(error.time is DateTime, true);
      expect(error.error is ArgumentError, true);
      expect(error.stackTrace is StackTrace, true);

      final message = error.generateTextMessage();
      expect(
        message,
        '''[ERROR] | ${TalkerDateTimeFormater(error.time).timeAndSeconds} | test message
Invalid argument(s)
''',
      );
    });
  });
}
