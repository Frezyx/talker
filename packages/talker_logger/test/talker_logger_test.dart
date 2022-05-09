import 'package:talker_logger/talker_logger.dart';
import 'package:test/test.dart';

class LogLevelLoggerFormater implements LoggerFormater {
  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    return details.level.title;
  }
}

final _messages = <String>[];
final _formatter = LogLevelLoggerFormater();
final logger = TalkerLogger(
  settings: const TalkerLoggerSettings(enableColors: false),
  formater: _formatter,
  output: (message) => _messages.add(message),
);

void main() {
  setUp(() {
    _messages.clear();
  });

  group('TalkerLogger', () {
    group('log', () {
      for (final level in LogLevel.values) {
        _testLog(level);
      }
    });
  });
}

void _testLog(LogLevel level) {
  test('LogLevel $level', () {
    logger.log('Message', level: level);
    expect(_messages, isNotEmpty);
    expect(_messages.length, 1);
    expect(_messages, contains(level.title));
  });
}
