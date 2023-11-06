import 'package:talker/src/talker_key.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerKey', () {
    test('returns correct key for each enum value', () {
      expect(TalkerKey.error.key, equals('error'));
      expect(TalkerKey.exception.key, equals('exception'));
      expect(TalkerKey.httpError.key, equals('http-error'));
      expect(TalkerKey.httpRequest.key, equals('http-request'));
      expect(TalkerKey.httpResponse.key, equals('http-response'));
      expect(TalkerKey.blocEvent.key, equals('bloc-event'));
      expect(TalkerKey.blocTransition.key, equals('bloc-transition'));
      expect(TalkerKey.route.key, equals('route'));
    });
  });
}
