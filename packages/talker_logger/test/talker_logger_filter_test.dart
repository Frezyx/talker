import 'package:talker_logger/talker_logger.dart';
import 'package:test/test.dart';

void main() {
  group('BaseTalkerLoggerFilter', () {
    group('shouldLog', () {
      for (final level in LogLevel.values) {
        _testShouldLog(level);
      }
    });
  });
}

void _testShouldLog(LogLevel level) {
  group(level.toString(), () {
    final currIndex = logLevelPriorityList.indexOf(level);
    final acceptForLogLevels = logLevelPriorityList.getRange(
      0,
      currIndex,
    );

    for (final acceptedLevel in acceptForLogLevels) {
      _testCompareLevels(level, acceptedLevel);
    }
  });
}

void _testCompareLevels(LogLevel level, LogLevel acceptedLevel) {
  test('Lvl: $level, Accepted Lvl: $acceptedLevel', () {
    final filter = _getFilter(level);
    final shouldLog = filter.shouldLog(acceptedLevel.toString(), acceptedLevel);
    expect(shouldLog, isTrue);
  });
}

TalkerLoggerFilter _getFilter(LogLevel level) =>
    LogLevelTalkerLoggerFilter(level);
