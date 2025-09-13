import 'package:riverpod/legacy.dart';
import 'package:talker/talker.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';
import 'package:test/test.dart';

void main() {
  group('RiverpodAddLog', () {
    test('Constructor should set values correctly', () {
      final fakeProvider = StateProvider((ref) => 0);
      final fakeValue = Object();
      final fakeSettings = TalkerRiverpodLoggerSettings();

      final log = RiverpodAddLog(
        provider: fakeProvider,
        value: fakeValue,
        settings: fakeSettings,
      );

      expect(log.provider, fakeProvider);
      expect(log.value, fakeValue);
      expect(log.settings, fakeSettings);
      expect(log.key, TalkerKey.riverpodAdd);

      final message = log.generateTextMessage();
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('initialized'));
    });
  });

  group('RiverpodAddLog with name', () {
    test('Constructor should set values correctly', () {
      final fakeProvider = StateProvider((ref) => 0, name: 'fakeProvider');
      final fakeValue = Object();
      final fakeSettings = TalkerRiverpodLoggerSettings();

      final log = RiverpodAddLog(
        provider: fakeProvider,
        value: fakeValue,
        settings: fakeSettings,
      );

      expect(log.provider, fakeProvider);
      expect(log.value, fakeValue);
      expect(log.settings, fakeSettings);
      expect(log.key, TalkerKey.riverpodAdd);

      final message = log.generateTextMessage();
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('initialized'));
      expect(message, contains('fakeProvider'));
    });
  });

  group('RiverpodUpdateLog', () {
    test('Constructor should set values correctly', () {
      final fakeProvider = StateProvider((ref) => 0);
      final fakePreviousValue = Object();
      final fakeNewValue = Object();
      final fakeSettings = TalkerRiverpodLoggerSettings();

      final log = RiverpodUpdateLog(
        provider: fakeProvider,
        previousValue: fakePreviousValue,
        newValue: fakeNewValue,
        settings: fakeSettings,
      );

      expect(log.provider, fakeProvider);
      expect(log.previousValue, fakePreviousValue);
      expect(log.newValue, fakeNewValue);
      expect(log.settings, fakeSettings);
      expect(log.key, TalkerKey.riverpodUpdate);

      final message = log.generateTextMessage();
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('updated'));
    });
  });

  group('RiverpodUpdateLog with name', () {
    test('Constructor should set values correctly', () {
      final fakeProvider = StateProvider((ref) => 0, name: 'fakeProvider');
      final fakePreviousValue = Object();
      final fakeNewValue = Object();
      final fakeSettings = TalkerRiverpodLoggerSettings();

      final log = RiverpodUpdateLog(
        provider: fakeProvider,
        previousValue: fakePreviousValue,
        newValue: fakeNewValue,
        settings: fakeSettings,
      );

      expect(log.provider, fakeProvider);
      expect(log.previousValue, fakePreviousValue);
      expect(log.newValue, fakeNewValue);
      expect(log.settings, fakeSettings);
      expect(log.key, TalkerKey.riverpodUpdate);

      final message = log.generateTextMessage();
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('updated'));
      expect(message, contains('fakeProvider'));
    });
  });

  group('RiverpodDisposeLog', () {
    test('Constructor should set values correctly', () {
      final fakeProvider = StateProvider((ref) => 0);
      final fakeSettings = TalkerRiverpodLoggerSettings();

      final log = RiverpodDisposeLog(
        provider: fakeProvider,
        settings: fakeSettings,
      );

      expect(log.provider, fakeProvider);
      expect(log.settings, fakeSettings);
      expect(log.key, TalkerKey.riverpodDispose);

      final message = log.generateTextMessage();
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('disposed'));
    });
  });

  group('RiverpodDisposeLog with name', () {
    test('Constructor should set values correctly', () {
      final fakeProvider = StateProvider((ref) => 0, name: 'fakeProvider');
      final fakeSettings = TalkerRiverpodLoggerSettings();

      final log = RiverpodDisposeLog(
        provider: fakeProvider,
        settings: fakeSettings,
      );

      expect(log.provider, fakeProvider);
      expect(log.settings, fakeSettings);
      expect(log.key, TalkerKey.riverpodDispose);

      final message = log.generateTextMessage();
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('disposed'));
      expect(message, contains('fakeProvider'));
    });
  });

  group('RiverpodFailLog', () {
    test('Constructor should set values correctly', () {
      final fakeProvider = StateProvider((ref) => 0);
      final fakeError = Object();
      final fakeStackTrace = StackTrace.empty;
      final fakeSettings = TalkerRiverpodLoggerSettings();

      final log = RiverpodFailLog(
        provider: fakeProvider,
        providerError: fakeError,
        providerStackTrace: fakeStackTrace,
        settings: fakeSettings,
      );

      expect(log.provider, fakeProvider);
      expect(log.providerError, fakeError);
      expect(log.providerStackTrace, fakeStackTrace);
      expect(log.key, TalkerKey.riverpodFail);

      final message = log.generateTextMessage();
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('failed'));
    });
  });

  group('RiverpodFailLog with name', () {
    test('Constructor should set values correctly', () {
      final fakeProvider = StateProvider((ref) => 0, name: 'fakeProvider');
      final fakeError = Object();
      final fakeStackTrace = StackTrace.empty;
      final fakeSettings = TalkerRiverpodLoggerSettings();

      final log = RiverpodFailLog(
        provider: fakeProvider,
        providerError: fakeError,
        providerStackTrace: fakeStackTrace,
        settings: fakeSettings,
      );

      expect(log.provider, fakeProvider);
      expect(log.providerError, fakeError);
      expect(log.providerStackTrace, fakeStackTrace);
      expect(log.key, TalkerKey.riverpodFail);

      final message = log.generateTextMessage();
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('failed'));
      expect(message, contains('fakeProvider'));
    });
  });
}
