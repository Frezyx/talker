import 'package:talker/src/utils/observers_manager.dart';
import 'package:talker/talker.dart';
import 'package:test/test.dart';

final _logsStore = <TalkerDataInterface>[];
final _errorsStore = <TalkerError>[];
final _exceptionsStore = <TalkerException>[];

class MockTalkerObserver extends TalkerObserver {
  @override
  void onError(TalkerError err) => _errorsStore.add(err);

  @override
  void onException(TalkerException e) => _exceptionsStore.add(e);

  @override
  void onLog(TalkerDataInterface log) => _logsStore.add(log);
}

class EmptyMockTalkerObserver extends TalkerObserver {}

void main() {
  group('TalkerObserver', () {
    setUp(() {
      _logsStore.clear();
      _errorsStore.clear();
      _exceptionsStore.clear();
    });

    final mockObserver = MockTalkerObserver();
    final emptyMockTalkerObserver = EmptyMockTalkerObserver();
    final observerManager =
        TalkerObserversManager([mockObserver, emptyMockTalkerObserver]);

    test('onError', () {
      observerManager.onError.call(TalkerError(ArgumentError()));
      expect(_errorsStore, isNotEmpty);
      expect(_logsStore, isEmpty);
      expect(_exceptionsStore, isEmpty);
    });

    test('onException', () {
      observerManager.onException.call(TalkerException(Exception()));
      expect(_errorsStore, isEmpty);
      expect(_logsStore, isEmpty);
      expect(_exceptionsStore, isNotEmpty);
    });

    test('onLog', () {
      observerManager.onLog.call(TalkerLog('msg'));
      expect(_errorsStore, isEmpty);
      expect(_logsStore, isNotEmpty);
      expect(_exceptionsStore, isEmpty);
    });
  });

  group('TalkerObserver integrated in Talker', () {
    setUp(() {
      _logsStore.clear();
      _errorsStore.clear();
      _exceptionsStore.clear();
    });

    final mockObserver = MockTalkerObserver();
    final emptyMockTalkerObserver = EmptyMockTalkerObserver();
    final talker = Talker(
      observers: [mockObserver, emptyMockTalkerObserver],
      settings: TalkerSettings(useConsoleLogs: false),
    );

    test('onError', () {
      talker.handle(ArgumentError());
      expect(_errorsStore, isNotEmpty);
      expect(_logsStore, isEmpty);
      expect(_exceptionsStore, isEmpty);
    });

    talker.configure(observers: [mockObserver, emptyMockTalkerObserver]);

    test('onException', () {
      talker.handle(Exception());

      expect(_errorsStore, isEmpty);
      expect(_logsStore, isEmpty);
      expect(_exceptionsStore, isNotEmpty);
    });

    test('onLog', () {
      talker.log('msg');
      expect(_errorsStore, isEmpty);
      expect(_logsStore, isNotEmpty);
      expect(_exceptionsStore, isEmpty);
    });
  });
}
