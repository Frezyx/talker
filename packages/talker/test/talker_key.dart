import 'package:talker/talker.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerKey', () {
    test('returns correct key for each enum value', () {
      expect(TalkerLogType.error.key, equals('error'));
      expect(TalkerLogType.critical.key, equals('critical'));
      expect(TalkerLogType.info.key, equals('info'));
      expect(TalkerLogType.debug.key, equals('debug'));
      expect(TalkerLogType.verbose.key, equals('verbose'));
      expect(TalkerLogType.warning.key, equals('warning'));
      expect(TalkerLogType.exception.key, equals('exception'));
      expect(TalkerLogType.httpError.key, equals('http-error'));
      expect(TalkerLogType.httpRequest.key, equals('http-request'));
      expect(TalkerLogType.httpResponse.key, equals('http-response'));
      expect(TalkerLogType.blocEvent.key, equals('bloc-event'));
      expect(TalkerLogType.blocTransition.key, equals('bloc-transition'));
      expect(TalkerLogType.blocClose.key, equals('bloc-close'));
      expect(TalkerLogType.blocCreate.key, equals('bloc-create'));
      expect(TalkerLogType.route.key, equals('route'));
    });

    test('fromLogLevel returns correct TalkerLogType', () {
      expect(TalkerLogType.fromLogLevel(LogLevel.error),
          equals(TalkerLogType.error));
      expect(TalkerLogType.fromLogLevel(LogLevel.critical),
          equals(TalkerLogType.critical));
      expect(TalkerLogType.fromLogLevel(LogLevel.info),
          equals(TalkerLogType.info));
      expect(TalkerLogType.fromLogLevel(LogLevel.debug),
          equals(TalkerLogType.debug));
      expect(TalkerLogType.fromLogLevel(LogLevel.verbose),
          equals(TalkerLogType.verbose));
      expect(TalkerLogType.fromLogLevel(LogLevel.warning),
          equals(TalkerLogType.warning));
    });

    test('fromKey returns correct TalkerLogType', () {
      expect(
        TalkerLogType.fromKey('error'),
        equals(TalkerLogType.error),
      );
      expect(
        TalkerLogType.fromKey('critical'),
        equals(TalkerLogType.critical),
      );
      expect(
        TalkerLogType.fromKey('info'),
        equals(TalkerLogType.info),
      );
      expect(
        TalkerLogType.fromKey('debug'),
        equals(TalkerLogType.debug),
      );
      expect(
        TalkerLogType.fromKey('verbose'),
        equals(TalkerLogType.verbose),
      );
      expect(
        TalkerLogType.fromKey('warning'),
        equals(TalkerLogType.warning),
      );
      expect(
        TalkerLogType.fromKey('exception'),
        equals(TalkerLogType.exception),
      );
      expect(
        TalkerLogType.fromKey('http-error'),
        equals(TalkerLogType.httpError),
      );
      expect(
        TalkerLogType.fromKey('http-request'),
        equals(TalkerLogType.httpRequest),
      );
      expect(
        TalkerLogType.fromKey('http-response'),
        equals(TalkerLogType.httpResponse),
      );
      expect(
        TalkerLogType.fromKey('bloc-event'),
        equals(TalkerLogType.blocEvent),
      );
      expect(
        TalkerLogType.fromKey('bloc-transition'),
        equals(TalkerLogType.blocTransition),
      );
      expect(
        TalkerLogType.fromKey('bloc-close'),
        equals(TalkerLogType.blocClose),
      );
      expect(
        TalkerLogType.fromKey('bloc-create'),
        equals(TalkerLogType.blocCreate),
      );
      expect(
        TalkerLogType.fromKey('route'),
        equals(TalkerLogType.route),
      );
    });
  });
}
