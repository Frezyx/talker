import 'package:talker/src/well_known_titles.dart';
import 'package:test/test.dart';

void main() {
  group('WellKnownTitles', () {
    test('returns correct title for each enum value', () {
      expect(WellKnownTitles.error.title, equals('ERROR'));
      expect(WellKnownTitles.exception.title, equals('EXCEPTION'));
      expect(WellKnownTitles.httpError.title, equals('http-error'));
      expect(WellKnownTitles.httpRequest.title, equals('http-request'));
      expect(WellKnownTitles.httpResponse.title, equals('http-response'));
      expect(WellKnownTitles.blocEvent.title, equals('bloc-event'));
      expect(WellKnownTitles.blocTransition.title, equals('bloc-transition'));
      expect(WellKnownTitles.route.title, equals('route'));
    });
  });
}
