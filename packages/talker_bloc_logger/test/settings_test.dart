import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerBlocLoggerSettings', () {
    test('Default settings', () {
      final settings = TalkerBlocLoggerSettings();

      expect(settings.enabled, true);
      expect(settings.printEvents, true);
      expect(settings.printTransitions, true);
      expect(settings.printChanges, false);
      expect(settings.printEventFullData, true);
      expect(settings.printStateFullData, true);
      expect(settings.printCreations, false);
      expect(settings.printClosings, false);
      expect(settings.transitionFilter, isNull);
      expect(settings.eventFilter, isNull);
    });

    test('Custom settings', () {
      final settings = TalkerBlocLoggerSettings(
        enabled: false,
        printEvents: false,
        printTransitions: false,
        printChanges: true,
        printEventFullData: false,
        printStateFullData: false,
        printCreations: true,
        printClosings: true,
        transitionFilter: (bloc, transition) => true,
        eventFilter: (bloc, event) => true,
      );

      expect(settings.enabled, false);
      expect(settings.printEvents, false);
      expect(settings.printTransitions, false);
      expect(settings.printChanges, true);
      expect(settings.printEventFullData, false);
      expect(settings.printStateFullData, false);
      expect(settings.printCreations, true);
      expect(settings.printClosings, true);
      expect(settings.transitionFilter, isNotNull);
      expect(settings.eventFilter, isNotNull);
    });
  });
}
