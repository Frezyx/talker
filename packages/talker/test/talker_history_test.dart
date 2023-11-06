import 'package:talker/talker.dart';
import 'package:test/test.dart';

void main() {
  group('Talker_History', () {
    late Talker talker;

    setUp(() {
      talker = Talker(settings: TalkerSettings(useConsoleLogs: false));
      talker.cleanHistory();
    });

    test('ON', () {
      _configureTalker(useHistory: true, talker: talker);
      _makeLogs(talker);

      final history = talker.history;

      expect(history, isNotEmpty);
      expect(history.length, equals(5));
    });

    test('OFF', () {
      _configureTalker(useHistory: false, talker: talker);
      _makeLogs(talker);

      final history = talker.history;

      expect(history, isEmpty);
    });

    test('HostoryOverflow', () {
      _configureTalker(useHistory: true, talker: talker, maxHistoryItems: 4);
      _makeLogs(talker);
      final history = talker.history;
      expect(history, isNotEmpty);
      expect(history.length, 4);
      expect(history.last.logLevel, LogLevel.debug);
    });
  });
}

void _makeLogs(Talker talker) {
  talker.error('log');
  talker.info('log');
  talker.verbose('log');
  talker.warning('log');
  talker.debug('log');
}

void _configureTalker({
  required bool useHistory,
  required Talker talker,
  int? maxHistoryItems,
}) {
  talker.configure(
    settings: TalkerSettings(
      useHistory: useHistory,
      useConsoleLogs: false,
      maxHistoryItems: maxHistoryItems,
    ),
  );
}
