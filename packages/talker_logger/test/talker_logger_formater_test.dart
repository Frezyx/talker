import 'package:talker_logger/talker_logger.dart';
import 'package:test/test.dart';

const _formater = ColoredLoggerFormatter();

void main() {
  final cases = [
    "m\ns\ng",
    "m\ne\ns\ns\na\ng\ne",
    "Middle\nlength\nmessage\nwith\nsome\ninfo",
    "  /s.f;gl,b;rlimvs'rlg't\\rgmtiu\n 453#4345//c.,le",
  ];

  final colorCases = ['Message test'];

  group('BaseTalkerLoggerFormater', () {
    group('fmt', () {
      for (final msg in cases) {
        _testFmt(msg);
      }
    });

    group('fmt without colors', () {
      for (final msg in colorCases) {
        _testWithoutColors(msg);
      }
    });
  });
}

void _testWithoutColors(String msg) {
  test('Msg: $msg', () {
    final fmtMsg = _formater.fmt(
      LogDetails(
        message: msg,
        level: LogLevel.debug,
        pen: AnsiPen(),
      ),
      const TalkerLoggerSettings(enableColors: false),
    );

    expect(fmtMsg, isNotNull);
    expect(fmtMsg, isNotEmpty);

    final parts = fmtMsg.split('\n');
    final msgWithoutUnderline = parts.getRange(0, parts.length - 1).join('\n');

    expect(msgWithoutUnderline, msg);
  });
}

void _testFmt(String msg) {
  test('Msg: $msg', () {
    final fmtMsg = _formater.fmt(
      LogDetails(
        message: msg,
        level: LogLevel.debug,
        pen: AnsiPen(),
      ),
      const TalkerLoggerSettings(),
    );

    expect(fmtMsg, isNotNull);
    expect(fmtMsg, isNotEmpty);

    final parts = fmtMsg.split('\n');
    final msgWithoutUnderline = parts.getRange(0, parts.length - 1).join('\n');

    expect(msgWithoutUnderline, msg);
  });
}
