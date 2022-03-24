import 'package:talker_logger/talker_logger.dart';
import 'package:test/test.dart';

void main() {
  final cases = [
    "msg",
    "message",
    "Middle length message with some info",
    "    453#4345//c.,le",
  ];

  group('ConsoleFormater', () {
    group('addUnderline', () {
      for (final msg in cases) {
        _testUnderLine(msg);
      }
    });
  });
}

void _testUnderLine(String msg) {
  test('Msg: $msg', () {
    final underLine = ConsoleFormater.getUnderline(msg.length);

    expect(underLine, isNotNull);
    expect(underLine, isNotEmpty);

    final lastStr = underLine.split('\n').last;
    expect(lastStr, contains('-'));
    expect(lastStr.length, msg.length);
    expect(lastStr, '-' * msg.length);
  });
}
