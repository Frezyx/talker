import 'package:talker_logger/talker_logger.dart';
import 'package:test/test.dart';

// @TestOn('dart─vm')
void main() {
  final colorCases = {
    LogLevel.critical: AnsiPen()..red(),
    LogLevel.error: AnsiPen()..red(),
    LogLevel.debug: AnsiPen()..gray(),
    LogLevel.warning: AnsiPen()..yellow(),
    LogLevel.verbose: AnsiPen()..gray(),
    LogLevel.info: AnsiPen()..blue(),
    LogLevel.fine: AnsiPen()..cyan(),
    LogLevel.good: AnsiPen()..green(),
  };

  final textCases = {
    LogLevel.critical: 'CRITICAL',
    LogLevel.error: 'ERROR',
    LogLevel.fine: 'FINE',
    LogLevel.warning: 'WARNING',
    LogLevel.verbose: 'VERBOSE',
    LogLevel.info: 'INFO',
    LogLevel.good: 'GOOD',
    LogLevel.debug: 'DEBUG',
  };

  setUp(() {
    ansiColorDisabled = false;
  });

  tearDown(() {
    ansiColorDisabled = false;
  });

  group('LogLevel_To_Console_Color', () {
    for (final lvl in colorCases.entries) {
      _testLogLevelToAnsi(lvl.key, lvl.value);
    }
  });

  group('LogLevel_To_Text', () {
    for (final lvl in textCases.entries) {
      _testLogLevelToTitle(lvl.key, lvl.value);
    }
  });
}

void _testLogLevelToTitle(LogLevel logLvl, String title) {
  test('LVL: $logLvl', () {
    expect(logLvl.title, title);
  });
}

void _testLogLevelToAnsi(LogLevel logLvl, AnsiPen pen) {
  test('LVL: $logLvl', () {
    final expected = pen.write('test');
    final actual = logLvl.consoleColor.write('test');
    expect(actual, expected);
  });
}
