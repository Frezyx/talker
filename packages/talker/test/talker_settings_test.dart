import 'package:talker/src/utils/time_format.dart';
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
  });
}

class HttpTalkerLog extends TalkerLog {
  HttpTalkerLog(String message) : super(message);

  @override
  AnsiPen get pen => AnsiPen()..blue();

  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return pen.write(message ?? '');
  }
}
