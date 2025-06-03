// ignore_for_file: invalid_use_of_protected_member, override_on_non_overriding_member

import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:talker/talker.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';
import 'package:test/test.dart';

class TestNotifier extends StateNotifier<String> {
  TestNotifier() : super("Initial State");

  void changeState(String newState) {
    state = "Updated State";
  }
}

class FamilyTestNotifier extends FamilyNotifier<int, String> {
  @override
  int build(String arg) {
    return arg.length;
  }

  void changeState(String newState) {
    state = newState.length;
  }
}

final familyProvider = NotifierProvider.family<FamilyTestNotifier, int, String>(
  FamilyTestNotifier.new,
);

final familyErrorProvider = FutureProvider.family<String, String>(
  (ref, arg) => throw ("Error"),
);

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  return container;
}

void main() {
  group('TalkerRiverpodObserver tests', () {
    late Talker talker;
    late ProviderContainer container;
    late StateNotifierProvider<TestNotifier, String> provider;
    late FutureProvider<String> errorProvider;
    late TalkerRiverpodObserver talkerRiverpodObserver;

    setUp(() {
      talker = Talker(
        settings: TalkerSettings(useConsoleLogs: false),
      );
      talkerRiverpodObserver = TalkerRiverpodObserver(
        talker: talker,
        settings: TalkerRiverpodLoggerSettings(
          enabled: true,
          printProviderDisposed: true,
        ),
      );
      provider = StateNotifierProvider<TestNotifier, String>(
        (ref) => TestNotifier(),
      );
      errorProvider = FutureProvider<String>((ref) => throw ("Error"));
      container = createContainer(
        observers: [talkerRiverpodObserver],
        overrides: [
          provider.overrideWith((ref) => TestNotifier()),
        ],
      );
    });

    test('didAddProvider', () {
      final expectedState = 'Initial State';
      container.read(provider);
      expect(
        talker.history.first.generateTextMessage(),
        contains(expectedState),
      );
    });

    test('didUpdateProvider', () async {
      final expectedState = 'Updated State';
      container.read(provider.notifier).changeState("Updated State");
      await Future.delayed(const Duration(milliseconds: 10));
      final log = talker.history.last;
      expect(log.generateTextMessage(), contains(expectedState));
    });

    test('didDisposeProvider', () async {
      container.read(provider);
      container.dispose();
      await Future.delayed(const Duration(milliseconds: 10));
      final log = talker.history.last;
      expect(log.generateTextMessage(), contains('disposed'));
    });

    test('providerDidFail', () async {
      container.read(errorProvider);
      await Future.delayed(const Duration(milliseconds: 10));
      final log = talker.history.first;
      expect(log.generateTextMessage(), contains('failed'));
    });

    group('with arguments', () {
      test('didAddProvider', () {
        const arg = "99";
        const initial = 2;
        container.read(familyProvider(arg));
        final generateTextMessage = talker.history.first.generateTextMessage();
        expect(generateTextMessage, contains("($arg)"));
        expect(generateTextMessage, contains("$initial"));
      });
      test('didUpdateProvider', () async {
        const arg = "99";
        const input = "999";
        const expectedChange = 3;
        container.read(familyProvider(arg));
        await container.pump();
        container.read(familyProvider(arg).notifier).changeState(input);
        await container.pump();
        final generateTextMessage = talker.history.last.generateTextMessage();
        expect(generateTextMessage, contains("($arg)"));
        expect(generateTextMessage, contains("$expectedChange"));
      });
      test('didDisposeProvider', () async {
        const arg = "99";
        container.read(familyProvider(arg));
        await container.pump();
        container.dispose();
        await container.pump();
        final generateTextMessage = talker.history.last.generateTextMessage();
        expect(generateTextMessage, contains("($arg)"));
        expect(generateTextMessage, contains('disposed'));
      });

      test('providerDidFail', () async {
        const arg = "99";
        try {
          final _ = container.read(familyErrorProvider(arg));
        } catch (_) {}
        await container.pump();
        final log = talker.history.first.generateTextMessage();
        expect(log, contains("($arg)"));
        expect(log, contains('failed'));
      });
    });
  });
}
