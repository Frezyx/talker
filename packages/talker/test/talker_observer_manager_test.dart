import 'package:talker/talker.dart';
import 'package:test/test.dart';

final _logsStore = <TalkerDataInterface>[];
final _errorsStore = <TalkerError>[];
final _exceptionsStore = <TalkerException>[];

class MockTalkerObserver extends TalkerObserver {
  @override
  Function(TalkerError err) get onError => (err) {
        _errorsStore.add(err);
      };

  @override
  Function(TalkerException err) get onException => (e) {
        _exceptionsStore.add(e);
      };

  @override
  Function(TalkerDataInterface log) get onLog => (log) {
        _logsStore.add(log);
      };
}

class EmptyMockTalkerObserver extends TalkerObserver {
  @override
  Function(TalkerError err) get onError => (err) {};

  @override
  Function(TalkerException err) get onException => (e) {};

  @override
  Function(TalkerDataInterface log) get onLog => (log) {};
}

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
