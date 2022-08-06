import 'package:talker_logger/talker_logger.dart';
import 'package:test/test.dart';

class LogLevelLoggerFormater implements LoggerFormatter {
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
    _expectInstance(_logger);
  });

  test('Constructor', () {
    final logger = TalkerLogger();
    _expectInstance(logger);
  });

  test('Constructor with fields', () {
    final logger = TalkerLogger(
      settings: const TalkerLoggerSettings(lineSymbol: '#'),
      filter: const LogLevelTalkerLoggerFilter(LogLevel.critical),
      formater: _formatter,
    );
    _expectInstance(logger);
    // ignore: unnecessary_type_check
    expect(logger.settings is TalkerLoggerSettings, true);
    expect(logger.settings.lineSymbol, '#');

    // ignore: unnecessary_type_check
    expect(logger.formater is LoggerFormatter, true);
    // ignore: unnecessary_type_check
    expect(logger.formater is LogLevelLoggerFormater, true);
  });

  test('Constructor copyWith', () {
    final messages = <String>[];
    var logger = TalkerLogger(
      output: (message) => messages.add(message),
    );
    logger = logger.copyWith(
      settings: const TalkerLoggerSettings(lineSymbol: '#'),
      filter: const LogLevelTalkerLoggerFilter(LogLevel.critical),
      formater: _formatter,
    );
    logger.critical('c');
    logger.critical('c');
    expect(2, messages.length);
    _expectInstance(logger);
    // ignore: unnecessary_type_check
    expect(logger.settings is TalkerLoggerSettings, true);
    expect(logger.settings.lineSymbol, '#');

    // ignore: unnecessary_type_check
    expect(logger.formater is LoggerFormatter, true);
    // ignore: unnecessary_type_check
    expect(logger.formater is LogLevelLoggerFormater, true);
  });

  test('Constructor copyWith empty', () {
    final messages = <String>[];
    var logger = TalkerLogger(
      settings: const TalkerLoggerSettings(lineSymbol: '#'),
      filter: const LogLevelTalkerLoggerFilter(LogLevel.critical),
      formater: _formatter,
      output: (message) => messages.add(message),
    );
    logger = logger.copyWith();
    logger.critical('c');
    logger.critical('c');
    expect(2, messages.length);
    _expectInstance(logger);
    // ignore: unnecessary_type_check
    expect(logger.settings is TalkerLoggerSettings, true);
    expect(logger.settings.lineSymbol, '#');

    // ignore: unnecessary_type_check
    expect(logger.formater is LoggerFormatter, true);
    // ignore: unnecessary_type_check
    expect(logger.formater is LogLevelLoggerFormater, true);
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

    test('Message length', () {
      final logger = TalkerLogger(
        settings: const TalkerLoggerSettings(enableColors: false),
        output: (message) => _messages.add(message),
        formater: const ColoredLoggerFormatter(),
      );
      final str = '────' * 1000;
      logger.log(str);
      expect(
        _messages[0],
        '${'────' * 1000}\n──────────────────────────────────────────────────────────────────────────────────────────────────────────────',
      );
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

void _expectInstance(TalkerLogger logger) {
  // ignore: unnecessary_type_check
  expect(logger is TalkerLoggerInterface, true);
  // ignore: unnecessary_type_check
  expect(logger is TalkerLogger, true);
}
