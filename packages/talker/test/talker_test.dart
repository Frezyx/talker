import 'package:talker/talker.dart';
import 'package:test/test.dart';

import 'talker_settings_test.dart';

class LikeErrorButNot {}

void main() {
  final talker = Talker(settings: TalkerSettings(useConsoleLogs: false));

  setUp(() {
    talker.cleanHistory();
  });

  group('Talker', () {
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

  test('Handle exception with logs enabled', () {
    talker.configure(
      settings: TalkerSettings(),
      logger: TalkerLogger(
        output: (message) {},
      ),
    );
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

  test('log', () async {
    const testLogMessage = 'Test log message';
    final talker = Talker(
      logger: TalkerLogger(
        output: (message) {},
      ),
    );
    talker.log(testLogMessage);

    expect(talker.history.length, 1);
    expect(
      talker.history.whereType<TalkerLog>().length,
      1,
    );
    expect(talker.history.first.message, testLogMessage);
  });

  test('logCustom', () async {
    final talker = Talker(
      logger: TalkerLogger(
        output: (message) {},
      ),
    );
    final httpLog = HttpTalkerLog('Http good');
    talker.logCustom(httpLog);

    expect(talker.history.length, 1);
    expect(
      talker.history.whereType<TalkerLog>().length,
      1,
    );
    expect(
      talker.history.whereType<HttpTalkerLog>().length,
      1,
    );
    expect(talker.history.first.message, httpLog.message);
  });

  test('logTyped', () async {
    final talker = Talker(
      logger: TalkerLogger(
        output: (message) {},
      ),
    );
    final httpLog = HttpTalkerLog('Http good');
    // ignore: deprecated_member_use_from_same_package
    talker.logTyped(httpLog);

    expect(talker.history.length, 1);
    expect(
      talker.history.whereType<TalkerLog>().length,
      1,
    );
    expect(
      talker.history.whereType<HttpTalkerLog>().length,
      1,
    );
    expect(talker.history.first.message, httpLog.message);
  });
}
