import 'package:talker/talker.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerKey', () {
    test('returns correct key for each enum value', () {
      expect(TalkerKey.error, equals('error'));
      expect(TalkerKey.critical, equals('critical'));
      expect(TalkerKey.info, equals('info'));
      expect(TalkerKey.debug, equals('debug'));
      expect(TalkerKey.verbose, equals('verbose'));
      expect(TalkerKey.warning, equals('warning'));
      expect(TalkerKey.exception, equals('exception'));
      expect(TalkerKey.httpError, equals('http-error'));
      expect(TalkerKey.httpRequest, equals('http-request'));
      expect(TalkerKey.httpResponse, equals('http-response'));
      expect(TalkerKey.blocEvent, equals('bloc-event'));
      expect(TalkerKey.blocTransition, equals('bloc-transition'));
      expect(TalkerKey.blocClose, equals('bloc-close'));
      expect(TalkerKey.blocCreate, equals('bloc-create'));
      expect(TalkerKey.route, equals('route'));
    });

    test('fromLogLevel returns correct TalkerLogType', () {
      expect(TalkerKey.fromLogLevel(LogLevel.error), equals(TalkerKey.error));
      expect(TalkerKey.fromLogLevel(LogLevel.critical),
          equals(TalkerKey.critical));
      expect(TalkerKey.fromLogLevel(LogLevel.info), equals(TalkerKey.info));
      expect(TalkerKey.fromLogLevel(LogLevel.debug), equals(TalkerKey.debug));
      expect(
          TalkerKey.fromLogLevel(LogLevel.verbose), equals(TalkerKey.verbose));
      expect(
          TalkerKey.fromLogLevel(LogLevel.warning), equals(TalkerKey.warning));
    });
  });
}
