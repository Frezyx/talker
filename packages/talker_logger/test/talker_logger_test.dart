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
final _logger = TalkerLogger(
  settings: const TalkerLoggerSettings(enableColors: false),
  formater: _formatter,
  output: (message) => _messages.add(message),
);

void main() {
  setUp(() {
    _messages.clear();
  });

  test('Instance', () {
    // ignore: unnecessary_type_check
    expect(_logger is TalkerLoggerInterface, true);
    // ignore: unnecessary_type_check
    expect(_logger is TalkerLogger, true);
  });

  test('Constructor', () {
    final logger = TalkerLogger();
    // ignore: unnecessary_type_check
    expect(logger is TalkerLoggerInterface, true);
    // ignore: unnecessary_type_check
    expect(logger is TalkerLogger, true);
  });

  group('TalkerLogger', () {
    group('log LogLevel', () {
      for (final level in LogLevel.values) {
        _testLog(level);
      }
    });
  });
  group('log methods LogLevel', () {
    test('error', () {
      _logger.error('Message');
      _expectMessageType(LogLevel.error);
    });
    test('debug', () {
      _logger.debug('Message');
      _expectMessageType(LogLevel.debug);
    });
    test('critical', () {
      _logger.critical('Message');
      _expectMessageType(LogLevel.critical);
    });
    test('info', () {
      _logger.info('Message');
      _expectMessageType(LogLevel.info);
    });
    test('fine', () {
      _logger.fine('Message');
      _expectMessageType(LogLevel.fine);
    });
    test('good', () {
      _logger.good('Message');
      _expectMessageType(LogLevel.good);
    });
    test('verbose', () {
      _logger.verbose('Message');
      _expectMessageType(LogLevel.verbose);
    });
    test('warning', () {
      _logger.warning('Message');
      _expectMessageType(LogLevel.warning);
    });
  });
}

void _testLog(LogLevel level) {
  test('LogLevel $level', () {
    _logger.log('Message', level: level);
    _expectMessageType(level);
  });
}

void _expectMessageType(LogLevel level) {
  expect(_messages, isNotEmpty);
  expect(_messages.length, 1);
  expect(_messages, contains(level.title));
}
