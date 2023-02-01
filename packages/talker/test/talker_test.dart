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
      talker.handleError(ArgumentError());
      talker.handleError(ArgumentError(), StackTrace.current, 'Some error');
      expect(talker.history, isNotEmpty);
      expect(talker.history.length, 2);
      expect(talker.history.first is TalkerError, true);
      expect(talker.history.last is TalkerError, true);
    });
  });

  test('Handle exception', () {
    talker.handleException(Exception());
    talker.handleException(Exception(), StackTrace.current, 'Some error');
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
}
