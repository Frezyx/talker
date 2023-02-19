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
Invalid argument(s)''',
      );
    });

    test('TalkerException', () async {
      final exception = TalkerException(
        Exception(),
        message: _testMessage,
        logLevel: LogLevel.critical,
        stackTrace: StackTrace.empty,
        title: _testTitle,
      );

      expect(exception is TalkerDataInterface, true);
      expect(exception is TalkerException, true);
      expect(exception.message, _testMessage);
      expect(exception.title, _testTitle);
      expect(exception.time is DateTime, true);
      expect(exception.exception is Exception, true);
      expect(exception.stackTrace is StackTrace, true);

      final message = exception.generateTextMessage();
      expect(
        message,
        '''[EXCEPTION] | ${TalkerDateTimeFormater(exception.time).timeAndSeconds} | test message
Exception''',
      );

      final exceptionWithStackTrace = TalkerException(
        Exception(),
        stackTrace: StackTrace.current,
      );

      final fmtStackTrace = exceptionWithStackTrace.displayStackTrace;
      expect(fmtStackTrace, isNotEmpty);
    });

    test('TalkerLog', () async {
      final log = TalkerLog(
        _testMessage,
        logLevel: LogLevel.debug,
        title: _testTitle,
      );

      expect(log is TalkerDataInterface, true);
      expect(log is TalkerLog, true);
      expect(log.message, _testMessage);
      expect(log.title, _testTitle);
      expect(log.time is DateTime, true);

      final message = log.generateTextMessage();
      expect(
        message,
        '''[test title] | ${TalkerDateTimeFormater(log.time).timeAndSeconds} | test message''',
      );
    });
  });
}
