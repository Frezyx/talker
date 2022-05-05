import 'package:talker/talker.dart';
import 'package:test/test.dart';

void main() {
  final talker = Talker();
  group('Talker_Settings', () {
    setUp(() {
      talker.cleanHistory();
    });

    test('Register errors', () async {
      final settings = TalkerSettings(
        useConsoleLogs: false,
      );
      talker.configure(settings: settings);
      final httpLog = HttpTalkerLog('Http good');
      talker.logTyped(httpLog);

      // expect(settings.registeredTypes, contains(httpLog.runtimeType));
      expect(
        talker.history.whereType<HttpTalkerLog>().isNotEmpty,
        true,
      );
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
