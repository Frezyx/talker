// ignore_for_file: unnecessary_type_check, leading_newlines_in_multiline_strings

import 'package:talker/talker.dart';
import 'package:test/test.dart';

const _testMessage = 'test message';
const _testTitle = 'test title';

void main() {
  group('TalkerData models', () {
    test('TalkerError', () async {
      final error = TalkerError(
        ArgumentError(),
        message: _testMessage,
        stackTrace: StackTrace.empty,
        title: _testTitle,
      );

      expect(error is TalkerData, true);
      expect(error is TalkerError, true);
      expect(error.message, _testMessage);
      expect(error.title, _testTitle);
      expect(error.time is DateTime, true);
      expect(error.error is ArgumentError, true);
      expect(error.stackTrace is StackTrace, true);

      final message = error.generateTextMessage();
      expect(
        message,
        '''[test title] | ${TalkerDateTimeFormatter(error.time).timeAndSeconds} | test message
Invalid argument(s)''',
      );
    });

    test('TalkerException', () async {
      final exception = TalkerException(
        Exception(),
        message: _testMessage,
        stackTrace: StackTrace.empty,
        title: _testTitle,
      );

      expect(exception is TalkerData, true);
      expect(exception is TalkerException, true);
      expect(exception.message, _testMessage);
      expect(exception.title, _testTitle);
      expect(exception.time is DateTime, true);
      expect(exception.exception is Exception, true);
      expect(exception.stackTrace is StackTrace, true);

      final message = exception.generateTextMessage();
      expect(
        message,
        '''[test title] | ${TalkerDateTimeFormatter(exception.time).timeAndSeconds} | test message
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
      final error = Error();
      final exception = Exception('Test Exception');
      final dateTime = DateTime.now();
      final log = TalkerLog(
        _testMessage,
        logLevel: LogLevel.debug,
        exception: exception,
        error: error,
        stackTrace: StackTrace.current,
        title: _testTitle,
        time: dateTime,
        pen: AnsiPen()..red(),
        key: 'custom-key',
      );

      expect(log is TalkerData, true);
      expect(log is TalkerLog, true);
      expect(log.message, equals(_testMessage));
      expect(log.logLevel, equals(LogLevel.debug));
      expect(log.exception, equals(exception));
      expect(log.error, equals(error));
      expect(log.stackTrace is StackTrace, true);
      expect(log.title, equals(_testTitle));
      expect(log.time, equals(dateTime));
      expect(log.pen, isNotNull);
      expect(log.key, equals('custom-key'));

      final message = log.generateTextMessage();
      expect(
        message,
        equals(
          '${log.displayTitleWithTime()}${log.displayMessage}${log.displayException}${log.displayError}${log.displayStackTrace}',
        ),
      );
    });
  });
}
