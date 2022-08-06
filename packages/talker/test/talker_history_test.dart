import 'package:talker/talker.dart';
import 'package:test/test.dart';

void main() {
  group('Talker_History', () {
    late TalkerInterface _talker;

    setUp(() {
      _talker = Talker();
      _talker.cleanHistory();
    });

    test('ON', () {
      _configureTalker(useHistory: true, talker: _talker);
      _makeLogs(_talker);

      final history = _talker.history;

      expect(history, isNotEmpty);
      expect(history.length, equals(6));
    });

    test('OFF', () {
      _configureTalker(useHistory: false, talker: _talker);
      _makeLogs(_talker);

      final history = _talker.history;

      expect(history, isEmpty);
    });

    test('HostoryOverflow', () {
      _configureTalker(useHistory: true, talker: _talker, maxHistoryItems: 4);
      _makeLogs(_talker);
      final history = _talker.history;
      expect(history, isNotEmpty);
      expect(history.length, 4);
      expect(history.first.logLevel, LogLevel.fine);
      expect(history.last.logLevel, LogLevel.debug);
    });
  });
}

void _makeLogs(TalkerInterface talker) {
  talker.good('log');
  talker.info('log');
  talker.fine('log');
  talker.verbose('log');
  talker.warning('log');
  talker.debug('log');
}

void _configureTalker({
  required bool useHistory,
  required TalkerInterface talker,
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
