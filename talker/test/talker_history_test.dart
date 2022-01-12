import 'package:talker/src/src.dart';
import 'package:test/test.dart';

void main() {
  group('Talker_History', () {
    late TalkerInterface _talker;

    setUp(() {
      _talker = Talker.instance;
      _talker.cleanHistory();
    });

    test('ON', () async {
      await _configureTalker(useHistory: true, talker: _talker);
      _makeLogs(_talker);

      final history = Talker.instance.history;

      expect(history, isNotEmpty);
      expect(history.length, equals(6));
    });

    test('OFF', () async {
      await _configureTalker(useHistory: false, talker: _talker);
      _makeLogs(_talker);

      final history = Talker.instance.history;

      expect(history, isEmpty);
    });
  });
}

void _makeLogs(TalkerInterface _talker) {
  _talker.good('Good log');
  _talker.info('Good log');
  _talker.fine('Good log');
  _talker.verbose('Good log');
  _talker.warning('Good log');
  _talker.debug('Good log');
}

Future<void> _configureTalker({
  required bool useHistory,
  required TalkerInterface talker,
}) async {
  await talker.configure(
    settings: TalkerSettings(useHistory: useHistory, useConsoleLogs: false),
  );
}
