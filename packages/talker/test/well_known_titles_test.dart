import 'package:talker/src/talker_key.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerKey', () {
    test('returns correct key for each enum value', () {
      expect(TalkerLogType.error.key, equals('error'));
      expect(TalkerLogType.exception.key, equals('exception'));
      expect(TalkerLogType.httpError.key, equals('http-error'));
      expect(TalkerLogType.httpRequest.key, equals('http-request'));
      expect(TalkerLogType.httpResponse.key, equals('http-response'));
      expect(TalkerLogType.blocEvent.key, equals('bloc-event'));
      expect(TalkerLogType.blocTransition.key, equals('bloc-transition'));
      expect(TalkerLogType.route.key, equals('route'));
    });
  });
}
