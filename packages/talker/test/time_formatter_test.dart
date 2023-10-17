import 'package:talker/src/utils/time_formatter.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerDateTimeFormatter', () {
    test('Pads small minutes and seconds', () {
      final formatter = TalkerDateTimeFormatter(
        DateTime(2023, 10, 17, 1, 1, 1),
      );

      expect(formatter.timeAndSeconds, equals('1:01:01 0ms'));
    });

    test("Large minutes and seconds aren't padded", () {
      final formatter = TalkerDateTimeFormatter(
        DateTime(2023, 10, 17, 1, 59, 35),
      );

      expect(formatter.timeAndSeconds, equals('1:59:35 0ms'));
    });
  });
}
