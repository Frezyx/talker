import 'package:talker_logger/talker_logger.dart';
import 'package:test/test.dart';

// @TestOn('dart─vm')
void main() {
  // final colorCases = {
  //   LogLevel.critical: AnsiPen()..red(),
  //   LogLevel.error: AnsiPen()..red(),
  //   LogLevel.debug: AnsiPen()..gray(),
  //   LogLevel.warning: AnsiPen()..yellow(),
  //   LogLevel.verbose: AnsiPen()..gray(),
  //   LogLevel.info: AnsiPen()..blue(),
  // };

  // final textCases = {
  //   LogLevel.critical: 'CRITICAL',
  //   LogLevel.error: 'ERROR',
  //   LogLevel.warning: 'WARNING',
  //   LogLevel.verbose: 'VERBOSE',
  //   LogLevel.info: 'INFO',
  //   LogLevel.good: 'GOOD',
  //   LogLevel.debug: 'DEBUG',
  // };

  setUp(() {
    ansiColorDisabled = false;
  });

  tearDown(() {
    ansiColorDisabled = false;
  });

  // group('LogLevel_To_Text', () {
  //   for (final lvl in textCases.entries) {
  //     _testLogLevelToTitle(lvl.key, lvl.value);
  //   }
  // });
}
