import 'package:talker/talker.dart';
import 'package:test/test.dart';

void main() {
  final talker = Talker(settings: TalkerSettings(useConsoleLogs: false));
  setUp(() {
    talker.cleanHistory();
  });

  group('Talker_toggle_enabled', () {
    group(
      'history',
      () {
        test('disable', () {
          talker.disable();
          talker.error('Test disabled log');

          expect(talker.history, isEmpty);
        });

        test('disable and enable', () {
          talker.disable();
          talker.error('Test disabled log');

          expect(talker.history, isEmpty);

          talker.enable();
          talker.error('Test disabled log');

          expect(talker.history, isNotEmpty);
        });
      },
    );
  });
}
