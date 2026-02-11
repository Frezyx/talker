import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:talker/talker.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';
import 'package:test/test.dart';

void main() {
  late Provider<Object> provider;
  late Provider<Object> namedProvider;
  late Object value;
  late Exception exception;
  late StackTrace stackTrace;
  late TalkerRiverpodLoggerSettings settings;
  late Mutation<Object?> mutation;

  setUp(() {
    provider = Provider((ref) => 0);
    namedProvider = Provider((ref) => 0, name: 'some-name');
    value = FakeObject(0);
    exception = FakeException();
    stackTrace = StackTrace.empty;
    settings = const TalkerRiverpodLoggerSettings();
    mutation = FakeNotifier.mutation;
  });

  group('RiverpodAddLog', () {
    test('sets values correctly', () {
      final log = RiverpodAddLog(
        provider: provider,
        value: value,
        settings: settings,
      );
      final message = log.generateTextMessage();

      expect(log.provider, provider);
      expect(log.value, value);
      expect(log.settings, settings);
      expect(log.key, TalkerKey.riverpodAdd);
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('initialized'));
      expect(message, contains(FakeObject.message(0)));
    });
    test('shows provider name if set', () {
      final log = RiverpodAddLog(
        provider: namedProvider,
        value: value,
        settings: settings,
      );
      final message = log.generateTextMessage();

      expect(message, contains('some-name'));
    });
    test('shows limited info with printStateFullData: false', () {
      final settings = TalkerRiverpodLoggerSettings(printStateFullData: false);
      final log = RiverpodAddLog(
        provider: provider,
        value: value,
        settings: settings,
      );

      final message = log.generateTextMessage();
      expect(message, contains(value.runtimeType.toString()));
      expect(message, isNot(contains(FakeObject.message(0))));
    });
  });

  group('RiverpodUpdateLog', () {
    test('sets values correctly', () {
      final newValue = FakeObject(1);
      final log = RiverpodUpdateLog(
        provider: provider,
        previousValue: value,
        newValue: newValue,
        settings: settings,
      );
      final message = log.generateTextMessage();

      expect(log.provider, provider);
      expect(log.previousValue, value);
      expect(log.newValue, newValue);
      expect(log.settings, settings);
      expect(log.key, TalkerKey.riverpodUpdate);
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('updated'));
      expect(message, contains(FakeObject.message(0)));
      expect(message, contains(FakeObject.message(1)));
    });
    test('shows provider name if set', () {
      final log = RiverpodAddLog(
        provider: namedProvider,
        value: value,
        settings: settings,
      );
      final message = log.generateTextMessage();

      expect(message, contains('some-name'));
    });
  });

  group('RiverpodDisposeLog', () {
    test('sets values correctly', () {
      final log = RiverpodDisposeLog(provider: provider, settings: settings);
      final message = log.generateTextMessage();

      expect(log.provider, provider);
      expect(log.settings, settings);
      expect(log.key, TalkerKey.riverpodDispose);
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('disposed'));
    });
    test('shows provider name, if set', () {
      final log = RiverpodDisposeLog(
        provider: namedProvider,
        settings: settings,
      );
      final message = log.generateTextMessage();

      expect(message, contains('some-name'));
    });
  });

  group('RiverpodFailLog', () {
    test('sets values correctly', () {
      final log = RiverpodFailLog(
        provider: provider,
        providerError: exception,
        providerStackTrace: stackTrace,
        settings: settings,
      );
      final message = log.generateTextMessage();

      expect(log.provider, provider);
      expect(log.providerError, exception);
      expect(log.providerStackTrace, stackTrace);
      expect(log.key, TalkerKey.riverpodFail);
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('failed'));
      expect(message, contains(FakeException.message));
    });
    test('shows provider name if set', () {
      final log = RiverpodFailLog(
        provider: namedProvider,
        providerError: exception,
        providerStackTrace: stackTrace,
        settings: settings,
      );
      final message = log.generateTextMessage();

      expect(message, contains('some-name'));
    });
    test('shows limited info with printFailFullData: false', () {
      final settings = TalkerRiverpodLoggerSettings(printFailFullData: false);
      final log = RiverpodFailLog(
        provider: provider,
        settings: settings,
        providerError: exception,
        providerStackTrace: stackTrace,
      );

      final message = log.generateTextMessage();
      expect(message, contains(exception.runtimeType.toString()));
      expect(message, isNot(contains(FakeException.message)));
    });
  });
  group('RiverpodMutationErrorLog', () {
    test('sets values correctly', () {
      final log = RiverpodMutationErrorLog(
        provider: provider,
        mutation: mutation,
        mutationError: exception,
        mutationStackTrace: stackTrace,
        settings: settings,
      );
      final message = log.generateTextMessage();

      expect(log.provider, provider);
      expect(log.mutation, mutation);
      expect(log.mutationError, exception);
      expect(log.mutationStackTrace, stackTrace);
      expect(log.key, TalkerKey.riverpodMutationFailed);
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('failed'));
      expect(message, contains(FakeException.message));
    });
    test('shows provider name if set', () {
      final log = RiverpodMutationErrorLog(
        provider: namedProvider,
        mutation: mutation,
        mutationError: exception,
        mutationStackTrace: stackTrace,
        settings: settings,
      );
      final message = log.generateTextMessage();

      expect(message, contains('some-name'));
    });
    test('shows limited info with printFailFullData: false', () {
      final settings = TalkerRiverpodLoggerSettings(printFailFullData: false);
      final log = RiverpodMutationErrorLog(
        provider: namedProvider,
        mutation: mutation,
        mutationError: exception,
        mutationStackTrace: stackTrace,
        settings: settings,
      );

      final message = log.generateTextMessage();
      expect(message, contains(exception.runtimeType.toString()));
      expect(message, isNot(contains(FakeException.message)));
    });
  });
  group('RiverpodMutationResetLog', () {
    test('sets values correctly', () {
      final log = RiverpodMutationResetLog(
        provider: provider,
        mutation: mutation,
        settings: settings,
      );
      final message = log.generateTextMessage();

      expect(log.provider, provider);
      expect(log.mutation, mutation);
      expect(log.settings, settings);
      expect(log.key, TalkerKey.riverpodMutationReset);
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('reset'));
    });
    test('shows provider name if set', () {
      final log = RiverpodMutationResetLog(
        provider: namedProvider,
        mutation: mutation,
        settings: settings,
      );
      final message = log.generateTextMessage();

      expect(message, contains('some-name'));
    });
  });
  group('RiverpodMutationStartLog', () {
    test('sets values correctly', () {
      final log = RiverpodMutationStartLog(
        provider: provider,
        mutation: mutation,
        settings: settings,
      );
      final message = log.generateTextMessage();

      expect(log.provider, provider);
      expect(log.mutation, mutation);
      expect(log.settings, settings);
      expect(log.key, TalkerKey.riverpodMutationStart);
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('started'));
    });
    test('shows provider name if set', () {
      final log = RiverpodMutationStartLog(
        provider: namedProvider,
        mutation: mutation,
        settings: settings,
      );
      final message = log.generateTextMessage();

      expect(message, contains('some-name'));
    });
  });
  group('RiverpodMutationSuccessLog', () {
    test('sets values correctly', () {
      final log = RiverpodMutationSuccessLog(
        provider: provider,
        mutation: mutation,
        result: value,
        settings: settings,
      );
      final message = log.generateTextMessage();

      expect(log.provider, provider);
      expect(log.mutation, mutation);
      expect(log.result, value);
      expect(log.settings, settings);
      expect(log.key, TalkerKey.riverpodMutationSuccess);
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('succeeded'));
      expect(message, contains(FakeObject.message(0)));
    });
    test('shows provider name if set', () {
      final log = RiverpodMutationSuccessLog(
        provider: namedProvider,
        mutation: mutation,
        result: value,
        settings: settings,
      );
      final message = log.generateTextMessage();

      expect(message, contains('some-name'));
    });
    test('shows limited info with printStateFullData: false', () {
      final settings = TalkerRiverpodLoggerSettings(printStateFullData: false);
      final log = RiverpodMutationSuccessLog(
        provider: provider,
        mutation: mutation,
        result: value,
        settings: settings,
      );

      final message = log.generateTextMessage();
      expect(message, contains(value.runtimeType.toString()));
      expect(message, isNot(contains(FakeObject.message(0))));
    });
  });
}

class FakeObject extends Object {
  FakeObject([this.value = 0]);
  int value;

  @override
  String toString() => message(value);
  static String message(int value) {
    return 'This is a Fake Object. Unsurpisingly. Value: $value';
  }
}

class FakeException implements Exception {
  @override
  String toString() => message;
  static const message = 'This is a Fake Exception. Unsurpisingly.';
}

class FakeNotifier extends Notifier<FakeObject> {
  @override
  FakeObject build() {
    return FakeObject(0);
  }

  static final mutation = Mutation<FakeObject>();
}
