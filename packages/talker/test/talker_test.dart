import 'package:talker/src/src.dart';
import 'package:talker/talker.dart';
import 'package:test/test.dart';

void main() {
  final talker = Talker(settings: TalkerSettings(useConsoleLogs: false));

  setUp(() {
    talker.cleanHistory();
  });

  group('Talker', () {
    test('Handle error from log', () async {
      talker.error('Some error', ArgumentError());
      talker.error('Some error', ArgumentError(), StackTrace.current);
      expect(talker.history, isNotEmpty);
      expect(talker.history.length, 2);
      expect(talker.history.first is TalkerError, true);
      expect(talker.history.last is TalkerError, true);
    });

    test('Handle exception from log', () async {
      talker.error('Some error', Exception());
      talker.error('Some error', Exception(), StackTrace.current);
      expect(talker.history, isNotEmpty);
      expect(talker.history.length, 2);
      expect(talker.history.first is TalkerException, true);
      expect(talker.history.last is TalkerException, true);
    });

    test('Handle error', () async {
      talker.handleError(ArgumentError());
      talker.handleError(ArgumentError(), StackTrace.current, 'Some error');
      expect(talker.history, isNotEmpty);
      expect(talker.history.length, 2);
      expect(talker.history.first is TalkerError, true);
      expect(talker.history.last is TalkerError, true);
    });
  });

  test('Handle exception', () async {
    talker.handleException(Exception());
    talker.handleException(Exception(), StackTrace.current, 'Some error');
    expect(talker.history, isNotEmpty);
    expect(talker.history.length, 2);
    expect(talker.history.first is TalkerException, true);
    expect(talker.history.last is TalkerException, true);
  });
}
