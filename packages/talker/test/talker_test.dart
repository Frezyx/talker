import 'package:talker/talker.dart';
import 'package:test/test.dart';

class LikeErrorButNot {}

void main() {
  final talker = Talker(settings: TalkerSettings(useConsoleLogs: false));

  setUp(() {
    talker.cleanHistory();
  });

  group('Talker', () {
    test('Handle error from log', () {
      talker.error('Some error', ArgumentError());
      talker.error('Some error', ArgumentError(), StackTrace.current);
      expect(talker.history, isNotEmpty);
      expect(talker.history.length, 2);
      expect(talker.history.first is TalkerError, true);
      expect(talker.history.last is TalkerError, true);
    });

    test('Handle exception from log', () {
      talker.error('Some error', Exception());
      talker.error('Some error', Exception(), StackTrace.current);
      expect(talker.history, isNotEmpty);
      expect(talker.history.length, 2);
      expect(talker.history.first is TalkerException, true);
      expect(talker.history.last is TalkerException, true);
    });

    test('Handle error', () {
      talker.handle(ArgumentError());
      talker.handle(ArgumentError(), StackTrace.current, 'Some error');
      expect(talker.history, isNotEmpty);
      expect(talker.history.length, 2);
      expect(talker.history.first is TalkerError, true);
      expect(talker.history.last is TalkerError, true);
    });
  });

  test('Handle exception', () {
    talker.handle(Exception());
    talker.handle(Exception(), StackTrace.current, 'Some error');
    expect(talker.history, isNotEmpty);
    expect(talker.history.length, 2);
    expect(talker.history.first is TalkerException, true);
    expect(talker.history.last is TalkerException, true);
  });

  test('Handle not exception or error', () {
    talker.handle('Text');
    talker.handle(LikeErrorButNot());
    expect(talker.history, isNotEmpty);
    expect(talker.history.length, 2);
    expect(talker.history.first is TalkerLog, true);
    expect(talker.history.last is TalkerLog, true);
  });

  test('register addon', () {
    final talkerWithAddons = Talker();
    talkerWithAddons.registerAddon(
      code: TalkerOriginalAddons.talkerBlocLogger.code,
      addon: 'addon',
    );
    expect(talkerWithAddons.addons, isNotEmpty);
    expect(
      talkerWithAddons.addons,
      {TalkerOriginalAddons.talkerBlocLogger.code: 'addon'},
    );
  });

  test('register two addons with one code', () {
    final talkerWithAddons = Talker();
    talkerWithAddons.registerAddon(
      code: TalkerOriginalAddons.talkerBlocLogger.code,
      addon: 'addon',
    );
    try {
      talkerWithAddons.registerAddon(
        code: TalkerOriginalAddons.talkerBlocLogger.code,
        addon: 'addon',
      );
    } catch (_) {
      // pass...
    }
    expect(talkerWithAddons.addons, isNotEmpty);
    expect(talkerWithAddons.addons.length, 1);
    expect(
      talkerWithAddons.addons,
      {TalkerOriginalAddons.talkerBlocLogger.code: 'addon'},
    );
  });

  test('reset addon', () {
    final talkerWithAddons = Talker();
    talkerWithAddons.registerAddon(
      code: TalkerOriginalAddons.talkerBlocLogger.code,
      addon: 'addon',
    );
    talkerWithAddons.resetAddon(TalkerOriginalAddons.talkerBlocLogger.code);
    expect(talkerWithAddons.addons, isEmpty);
  });

  test('Equality', () {
    final talker1 = Talker();
    final talker2 = Talker();
    expect(talker1, isNot(talker2));
    expect(talker1, talker1);
  });

  test('hashCode', () async {
    final talker = Talker();

    expect(talker.hashCode, isNotNull);
    expect(talker.hashCode, isNot(0));
  });
}
