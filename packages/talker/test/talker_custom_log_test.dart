import 'package:talker/talker.dart';
import 'package:test/test.dart';

final _customLogColor = AnsiPen()..xterm(121);
final _customLogKey = 'custom_log_key';
final _customLogTitle = 'Custom';

final _customLog2Key = 'custom_log_2_key';

class TestCustomLog extends TalkerLog {
  TestCustomLog(String super.message);

  @override
  String get title => _customLogTitle;

  @override
  String? get key => _customLogKey;

  @override
  AnsiPen get pen => _customLogColor;
}

class Test2CustomLog extends TalkerLog {
  Test2CustomLog(String super.message);

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
    });
  });
}
