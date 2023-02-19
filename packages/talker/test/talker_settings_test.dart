import 'package:talker/talker.dart';
import 'package:test/test.dart';

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
      talker.logTyped(httpLog);

      // expect(settings.registeredTypes, contains(httpLog.runtimeType));
      expect(
        talker.history.whereType<HttpTalkerLog>().isNotEmpty,
        true,
      );
    });

    test('Equality', () async {
      final settings = TalkerSettings(
        useConsoleLogs: false,
      );

      final settings2 = TalkerSettings(
        useConsoleLogs: false,
      );

      expect(settings, settings2);
    });

    test('hashCode', () async {
      final settings = TalkerSettings(
        useConsoleLogs: false,
      );

      expect(settings.hashCode, isNotNull);
      expect(settings.hashCode, isNot(0));
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
      expect(newSettings.maxHistoryItems, 200);
    });
  });
}

class HttpTalkerLog extends TalkerLog {
  HttpTalkerLog(String message) : super(message);

  @override
  AnsiPen get pen => AnsiPen()..blue();

  @override
  String generateTextMessage() {
    return pen.write(message);
  }
}
