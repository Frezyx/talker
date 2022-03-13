import 'package:talker/talker.dart';
import 'package:test/test.dart';

void main() {
  group('Talker_Settings', () {
    setUp(() {
      Talker.instance.cleanHistory();
    });

    test('Register errors', () async {
      final settings = TalkerSettings(
        useConsoleLogs: false,
        registeredTypes: [HttpTalkerLog],
      );
      await _configureTalker(settings);

      final httpLog = HttpTalkerLog('Http good');
      Talker.instance.logTyped(httpLog);

      expect(settings.registeredTypes, contains(httpLog.runtimeType));
      expect(
        Talker.instance.history.whereType<HttpTalkerLog>().isNotEmpty,
        true,
      );
    });
  });
}

Future<void> _configureTalker(TalkerSettings settings) async {
  await Talker.instance.configure(
    settings: settings,
  );
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
