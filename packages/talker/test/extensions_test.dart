import 'package:talker/talker.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerExtensions', () {
    test('HistoryListText', () async {
      final error = TalkerError(ArgumentError());
      final exception = TalkerException(Exception());
      final log = TalkerLog('message');

      final data = <TalkerDataInterface>[error, exception, log];
      final fullMsg = data.text;
      final expectedMsg =
          '${error.generateTextMessage()}\n${exception.generateTextMessage()}\n${log.generateTextMessage()}\n';
      expect(fullMsg, expectedMsg);
    });
  });

  group('TalkerOriginalAddonsExt', () {
    test('code', () async {
      expect('talker_dio_logger', TalkerOriginalAddons.talkerDioLogger.code);
      expect('talker_bloc_logger', TalkerOriginalAddons.talkerBlocLogger.code);
    });
  });
}
