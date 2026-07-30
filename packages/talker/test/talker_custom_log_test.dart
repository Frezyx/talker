import 'package:talker/talker.dart';
import 'package:test/test.dart';

final _customLogColor = AnsiPen()..xterm(121);
final _customLogKey = 'custom_log_key';
final _customLogTitle = 'Custom';

final _customLog2Key = 'custom_log_2_key';

class TestCustomLog extends TalkerLog {
  TestCustomLog(String message) : super(message);

  @override
  String get title => _customLogTitle;

  @override
  String? get key => _customLogKey;

  @override
  AnsiPen get pen => _customLogColor;
}

class Test2CustomLog extends TalkerLog {
  Test2CustomLog(String message) : super(message);

  @override
  String? get key => _customLog2Key;
}

void main() {
  final talker = Talker(settings: TalkerSettings(useConsoleLogs: false));

  setUp(() {
    talker.cleanHistory();
  });

  group('CustomLog', () {
    group('All fields correct', () {
      test('with object settings', () {
        final message = 'Hello from console!';
        final log = TestCustomLog(message);

        expect(log.message, message);
        expect(log.title, _customLogTitle);
        expect(log.key, _customLogKey);
        expect(log.pen, _customLogColor);
        expect(log.logLevel, null);
        expect(log.error, null);
        expect(log.exception, null);
        expect(log.stackTrace, null);
        expect(log.time, isNotNull);
      });

      test('without object settings', () {
        final message = 'Hello from console!';
        final log = Test2CustomLog(message);

        expect(log.message, message);
        expect(log.title, 'log');
        expect(log.key, _customLog2Key);
        expect(log.pen, null);
        expect(log.logLevel, null);
        expect(log.error, null);
        expect(log.exception, null);
        expect(log.stackTrace, null);
        expect(log.time, isNotNull);
      });

      test('with general settings', () {
        final message = 'Hello from console!';
        final talkerLog = Test2CustomLog(message);

        talker.configure(
          settings: TalkerSettings(
            useConsoleLogs: false,
            colors: {_customLog2Key: _customLogColor},
            titles: {_customLog2Key: _customLogTitle},
          ),
        );
        talker.logCustom(talkerLog);
        final log = talker.history.last;

        expect(log.message, message);
        expect(log.title, _customLogTitle);
        expect(log.key, _customLog2Key);
        expect(log.pen, _customLogColor);
        expect(log.logLevel, null);
        expect(log.error, null);
        expect(log.exception, null);
        expect(log.stackTrace, null);
        expect(log.time, isNotNull);
      });

      test('custom pen should override default key color', () {
        // This test verifies the fix for:
        // https://github.com/Frezyx/talker/issues/313
        // When a TalkerLog has both a custom pen and a key that matches
        // a default log type (like 'debug'), the custom pen should be used.
        final customPen = AnsiPen()..xterm(46);
        final message = 'WITH A KEY';
        final talkerLog = TalkerLog(
          message,
          pen: customPen,
          key: TalkerKey.debug, // Uses a key that has a default color
        );

        talker.configure(
          settings: TalkerSettings(
            useConsoleLogs: false,
          ),
        );
        talker.logCustom(talkerLog);
        final log = talker.history.last;

        expect(log.message, message);
        expect(log.key, TalkerKey.debug);
        // The custom pen should be preserved, not overridden by the debug key's default color
        expect(log.pen, customPen);
      });

      test('default key color is used when no custom pen provided', () {
        final message = 'WITHOUT A PEN';
        final talkerLog = TalkerLog(
          message,
          key: TalkerKey.debug, // Uses a key that has a default color
        );

        talker.configure(
          settings: TalkerSettings(
            useConsoleLogs: false,
          ),
        );
        talker.logCustom(talkerLog);
        final log = talker.history.last;

        expect(log.message, message);
        expect(log.key, TalkerKey.debug);
        // When no custom pen is provided, should use the default color for debug key
        expect(log.pen, isNotNull);
      });
    });
  });
}
