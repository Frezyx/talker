import 'package:talker_logger/talker_logger.dart';
import 'package:test/test.dart';

const _coloredFormatter = ColoredLoggerFormatter();
const _extendedFormatter = ExtendedLoggerFormatter();

void main() {
  final cases = [
    "m\ns\ng",
    "m\ne\ns\ns\na\ng\ne",
    "Middle\nlength\nmessage\nwith\nsome\ninfo",
    "  /s.f;gl,b;rlimvs'rlg't\\rgmtiu\n 453#4345//c.,le",
  ];

  final colorCases = ['Message test'];

  group('ColoredLoggerFormatter', () {
    group('fmt', () {
      for (final msg in cases) {
        _testFmt(msg, _coloredFormatter);
      }
    });

    group('fmt without colors', () {
      for (final msg in colorCases) {
        _testWithoutColors(msg, _coloredFormatter);
      }
    });
  });

  group('ExtendedLoggerFormatter', () {
    group('fmt', () {
      for (final msg in cases) {
        _testFmt(
          msg,
          _extendedFormatter,
          startMessageIndex: 1,
          additionalLineSign: '| ',
        );
      }
    });

    group('fmt without colors', () {
      for (final msg in colorCases) {
        _testWithoutColors(
          msg,
          _extendedFormatter,
          startMessageIndex: 1,
          additionalLineSign: '| ',
        );
      }
    });
  });
}

void _testWithoutColors(
  String msg,
  LoggerFormatter formatter, {
  int startMessageIndex = 0,
  int endMessageIndex = 1,
  String additionalLineSign = '',
}) {
  test('Msg: $msg', () {
    final fmtMsg = formatter.fmt(
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
    final msgWithoutUnderline = parts
        .getRange(startMessageIndex, parts.length - endMessageIndex)
        .map((e) => e.replaceRange(0, additionalLineSign.length, ''))
        .join('\n');

    expect(msgWithoutUnderline, msg);
  });
}

void _testFmt(
  String msg,
  LoggerFormatter formatter, {
  int startMessageIndex = 0,
  int endMessageIndex = 1,
  String additionalLineSign = '',
}) {
  test('Msg: $msg', () {
    final fmtMsg = formatter.fmt(
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
    final msgWithoutLines =
        parts.getRange(startMessageIndex, parts.length - endMessageIndex);
    final cleanTxt = msgWithoutLines
        .map((e) => e.replaceRange(0, additionalLineSign.length, ''))
        .join('\n');
    expect(cleanTxt, msg);
  });
}
