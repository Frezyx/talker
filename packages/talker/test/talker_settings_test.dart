import 'package:talker/talker.dart';
import 'package:test/test.dart';

import '../example/talker_example.dart';

void main() {
  final talker = Talker();
  group('TalkerSettings', () {
    setUp(() {
      talker.cleanHistory();
    });

    test('Register errors', () async {
      final settings = TalkerSettings(
        useConsoleLogs: false,
      );
      talker.configure(
        settings: settings,
        logger: TalkerLogger(),
      );
      final httpLog = HttpTalkerLog('Http good');
      talker.logCustom(httpLog);

      expect(
        talker.history.whereType<HttpTalkerLog>().isNotEmpty,
        true,
      );
    });

    test('copyWith', () async {
      final settings = TalkerSettings();
      final newSettings = settings.copyWith(
        enabled: false,
        useHistory: false,
        useConsoleLogs: false,
        maxHistoryItems: 999,
      );

      expect(newSettings.enabled, false);
      expect(newSettings.useConsoleLogs, false);
      expect(newSettings.useHistory, false);
      expect(newSettings.maxHistoryItems, 999);
    });

    test('copyWith empty', () async {
      final settings = TalkerSettings();
      final newSettings = settings.copyWith();

      expect(newSettings.enabled, true);
      expect(newSettings.useConsoleLogs, true);
      expect(newSettings.useHistory, true);
      expect(newSettings.maxHistoryItems, 1000);
    });

    test('Custom log: colors contains custom pen', () async {
      final pen = AnsiPen()..green();

      final settings = TalkerSettings(
        useConsoleLogs: false,
        colors: {
          YourCustomLog.logKey: pen,
        },
      );

      final talker = Talker(settings: settings);

      final customLog = YourCustomLog('Custom log message');
      talker.logCustom(customLog);

      expect(
        settings.colors[YourCustomLog.logKey],
        pen,
      );
    });

    test('Custom log: titles contains custom logs title', () async {
      final settings = TalkerSettings(
        useConsoleLogs: false,
        titles: {
          YourCustomLog.logKey: 'Custom title',
        },
      );

      final talker = Talker(settings: settings);

      final customLog = YourCustomLog('Custom log message');
      talker.logCustom(customLog);

      expect(
        settings.titles[YourCustomLog.logKey],
        'Custom title',
      );
    });
  });
}

class HttpTalkerLog extends TalkerLog {
  HttpTalkerLog(String message) : super(message);

  @override
  AnsiPen get pen => AnsiPen()..blue();

  @override
  String generateTextMessage({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return pen.write(message ?? '');
  }
}
