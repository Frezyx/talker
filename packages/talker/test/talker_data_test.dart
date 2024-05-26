import 'package:talker/talker.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerData', () {
    test('constructor sets correct values', () {
      final error = Error();
      final exception = Exception('Test Exception');
      final dateTime = DateTime.now();
      final talkerData = TalkerData(
        'Test Message',
        logLevel: LogLevel.debug,
        exception: exception,
        error: error,
        stackTrace: StackTrace.current,
        title: 'custom-title',
        time: dateTime,
        pen: AnsiPen()..red(),
        key: 'custom-key',
      );

      expect(talkerData.message, equals('Test Message'));
      expect(talkerData.logLevel, equals(LogLevel.debug));
      expect(talkerData.exception, equals(exception));
      expect(talkerData.error, equals(error));
      expect(talkerData.stackTrace is StackTrace, true);
      expect(talkerData.title, equals('custom-title'));
      expect(talkerData.time, equals(dateTime));
      expect(talkerData.pen, isNotNull);
      expect(talkerData.key, equals('custom-key'));
    });

    test('generateTextMessage returns correct message format', () {
      final talkerData = TalkerData(
        'Test Message',
        logLevel: LogLevel.debug,
        exception: Exception('Test Exception'),
        error: Error(),
        stackTrace: StackTrace.current,
        title: 'custom-title',
      );

      final generatedMessage = talkerData.generateTextMessage();
      expect(
        generatedMessage,
        equals(
          '${talkerData.displayTitleWithTime()}${talkerData.displayMessage}${talkerData.displayStackTrace}',
        ),
      );
    });
  });

  group('FieldsToDisplay extension', () {
    test('displayTitleWithTime returns correct format', () {
      final dateTime = DateTime.now();
      final talkerData = TalkerData(
        'Test Message',
        time: dateTime,
      );

      final displayTitleWithTime = talkerData.displayTitleWithTime();
      expect(
          displayTitleWithTime,
          equals(
              '[log] | ${TalkerDateTimeFormatter(dateTime).timeAndSeconds} | '));
    });

    test('displayStackTrace returns correct format', () {
      final talkerData = TalkerData(
        'Test Message',
        stackTrace: StackTrace.current,
      );

      final displayStackTrace = talkerData.displayStackTrace;
      expect(displayStackTrace, startsWith('\nStackTrace:'));
    });

    test('displayException returns correct format', () {
      final talkerData = TalkerData(
        'Test Message',
        exception: Exception('Test Exception'),
      );

      final displayException = talkerData.displayException;
      expect(displayException, startsWith('\nException:'));
    });

    test('displayMessage returns correct format', () {
      final talkerData = TalkerData(
        'Test Message',
      );

      final displayMessage = talkerData.displayMessage;
      expect(displayMessage, equals('Test Message'));
    });

    test('displayTime returns correct format', () {
      final dateTime = DateTime.now();
      final talkerData = TalkerData(
        'Test Message',
        time: dateTime,
      );

      final displayTime = talkerData.displayTime();
      expect(displayTime,
          equals(TalkerDateTimeFormatter(dateTime).timeAndSeconds));
    });
  });
}
