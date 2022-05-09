import 'package:talker/talker.dart';
import 'package:test/test.dart';

final _logsStore = <TalkerDataInterface>[];
final _errorsStore = <TalkerError>[];
final _exceptionsStore = <TalkerException>[];

class MockTalkerObserver extends TalkerObserver {
  @override
  Function(TalkerError err) get onError => (err) => _errorsStore.add(err);

  @override
  Function(TalkerException err) get onException =>
      (e) => _exceptionsStore.add(e);

  @override
  Function(TalkerDataInterface log) get onLog => (log) => _logsStore.add(log);
}

void main() {
  group('TalkerObserver', () {
    final mockObserver = MockTalkerObserver();

    setUp(() {
      _logsStore.clear();
      _errorsStore.clear();
      _exceptionsStore.clear();
    });
    test('onError', () {
      mockObserver.onError.call(TalkerError(ArgumentError()));
      expect(_errorsStore, isNotEmpty);
      expect(_logsStore, isEmpty);
      expect(_exceptionsStore, isEmpty);
    });

    test('onException', () {
      mockObserver.onException.call(TalkerException(Exception()));
      expect(_errorsStore, isEmpty);
      expect(_logsStore, isEmpty);
      expect(_exceptionsStore, isNotEmpty);
    });

    test('onLog', () {
      mockObserver.onLog.call(TalkerLog('msg'));
      expect(_errorsStore, isEmpty);
      expect(_logsStore, isNotEmpty);
      expect(_exceptionsStore, isEmpty);
    });
  });
}
