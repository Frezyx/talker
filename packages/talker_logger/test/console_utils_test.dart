import 'package:talker_logger/talker_logger.dart';
import 'package:test/test.dart';

void main() {
  final cases = [
    "msg",
    "message",
    "Middle length message with some info",
    "    453#4345//c.,le",
  ];

  group('ConsoleUtils', () {
    group('addUnderline', () {
      for (final msg in cases) {
        _testUnderLine(msg);
      }
    });

    group('addCustomUnderline', () {
      for (final msg in cases) {
        _testCustomUnderLine(msg, '#');
      }
    });

    group('addTopline', () {
      for (final msg in cases) {
        _testTopLine(msg);
      }
    });

    group('addCustomTopline', () {
      for (final msg in cases) {
        _testCustomTopLine(msg, '#');
      }
    });
  });
}

void _testTopLine(String msg) {
  test('Msg: $msg', () {
    final topLine = ConsoleUtils.getTopline(msg.length);

    expect(topLine, isNotNull);
    expect(topLine, isNotEmpty);

    final firstLine = topLine.split('\n').first;
    expect(firstLine, contains('─'));
    expect(firstLine.length, msg.length);
    expect(firstLine, '─' * msg.length);
  });
}

void _testCustomTopLine(String msg, String lineSymbol) {
  test('Msg: $msg', () {
    final topLine = ConsoleUtils.getTopline(
      msg.length,
      lineSymbol: lineSymbol,
    );

    expect(topLine, isNotNull);
    expect(topLine, isNotEmpty);

    final firstStr = topLine.split('\n').first;
    expect(firstStr, contains(lineSymbol));
    expect(firstStr.length, msg.length);
    expect(firstStr, lineSymbol * msg.length);
  });
}

void _testUnderLine(String msg) {
  test('Msg: $msg', () {
    final underLine = ConsoleUtils.getUnderline(msg.length);

    expect(underLine, isNotNull);
    expect(underLine, isNotEmpty);

    final lastStr = underLine.split('\n').last;
    expect(lastStr, contains('─'));
    expect(lastStr.length, msg.length);
    expect(lastStr, '─' * msg.length);
  });
}

void _testCustomUnderLine(String msg, String lineSymbol) {
  test('Msg: $msg', () {
    final underLine = ConsoleUtils.getUnderline(
      msg.length,
      lineSymbol: lineSymbol,
    );

    expect(underLine, isNotNull);
    expect(underLine, isNotEmpty);

    final lastStr = underLine.split('\n').last;
    expect(lastStr, contains(lineSymbol));
    expect(lastStr.length, msg.length);
    expect(lastStr, lineSymbol * msg.length);
  });
}
