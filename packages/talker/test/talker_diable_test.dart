import 'package:talker/talker.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    Talker.instance.cleanHistory();
  });

  group('Talker_toggle_enabled', () {
    group(
      'history',
      () {
        test('disable', () {
          Talker.instance.disable();
          Talker.instance.error('Test disabled log');

          expect(Talker.instance.history, isEmpty);
        });

        test('disable and enable', () {
          Talker.instance.disable();
          Talker.instance.error('Test disabled log');

          expect(Talker.instance.history, isEmpty);

          Talker.instance.enable();
          Talker.instance.error('Test disabled log');

          expect(Talker.instance.history, isNotEmpty);
        });
      },
    );
  });
}
