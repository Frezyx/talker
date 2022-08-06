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

    group('addToplineWithCorner', () {
      for (final msg in cases) {
        _testCustomTopLine(msg, '#', withCorner: true);
      }
    });

    group('addUnderlineWithCorner', () {
      for (final msg in cases) {
        _testCustomUnderLine(msg, '#', withCorner: true);
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

void _testCustomTopLine(
  String msg,
  String lineSymbol, {
  bool withCorner = false,
}) {
  test('Msg: $msg', () {
    final topLine = ConsoleUtils.getTopline(
      msg.length,
      lineSymbol: lineSymbol,
      withCorner: withCorner,
    );

    expect(topLine, isNotNull);
    expect(topLine, isNotEmpty);

    final firstStr = topLine.split('\n').first;
    expect(firstStr, contains(lineSymbol));
    expect(firstStr.length, withCorner ? msg.length + 1 : msg.length);
    expect(
      firstStr,
      withCorner ? '┌${lineSymbol * msg.length}' : lineSymbol * msg.length,
    );
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

void _testCustomUnderLine(
  String msg,
  String lineSymbol, {
  bool withCorner = false,
}) {
  test('Msg: $msg', () {
    final underLine = ConsoleUtils.getUnderline(
      msg.length,
      lineSymbol: lineSymbol,
      withCorner: withCorner,
    );

    expect(underLine, isNotNull);
    expect(underLine, isNotEmpty);

    final lastStr = underLine.split('\n').last;
    expect(lastStr, contains(lineSymbol));
    expect(lastStr.length, withCorner ? msg.length + 1 : msg.length);
    expect(
      lastStr,
      withCorner ? '└${lineSymbol * msg.length}' : lineSymbol * msg.length,
    );
  });
}
