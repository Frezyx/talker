// ignore_for_file: invalid_use_of_protected_member, override_on_non_overriding_member

import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:talker/talker.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerRiverpodObserver', () {
    late Talker talker;
    late ProviderContainer container;

    late TalkerRiverpodObserver talkerRiverpodObserver;

    setUp(() {
      talker = Talker(
        settings: TalkerSettings(useConsoleLogs: false),
        logger: TalkerLogger(
          settings: TalkerLoggerSettings(level: LogLevel.verbose),
        ),
      );
      talkerRiverpodObserver = TalkerRiverpodObserver(
        talker: talker,
        settings: TalkerRiverpodLoggerSettings(
          enabled: true,
          printProviderDisposed: true,
          printMutationReset: true,
        ),
      );

      container = ProviderContainer.test(
        observers: [talkerRiverpodObserver],
        retry: (retryCount, error) => null,
      );
    });

    tearDown(() {
      talker.cleanHistory();
    });

    test('didAddProvider', () {
      final expectedState = 'Initial State';
      container.read(testProvider);
      expect(
        talker.history.first.generateTextMessage(),
        contains(expectedState),
      );
    });
    test('didUpdateProvider', () async {
      final input = 'Updated State';

      container.listen(testProvider, (previous, next) {});
      container.read(testProvider);
      container.read(testProvider.notifier).changeState(input);

      final log = talker.history.last;
      expect(log.generateTextMessage(), contains(input));
    });
    test('didDisposeProvider', () async {
      container.read(testProvider);

      await container.pump();

      final log = talker.history.last;
      expect(log.generateTextMessage(), contains('disposed'));
    });
    test('providerDidFail', () async {
      final sub = container.listen(errorProvider.future, (previous, next) {});
      try {
        final _ = await sub.read();
      } catch (_) {
      } finally {
        sub.close();
      }
      final log = talker.history.first;
      expect(log.generateTextMessage(), contains('failed'));
    });
    test('mutationError', () async {
      container.listen(testProvider, (previous, next) {});
      container.listen(TestNotifier.failMutation, (previous, next) {});

      try {
        await TestNotifier.failMutation.run(container, (transaction) async {
          transaction.get(testProvider.notifier).fail();
        });
      } catch (_) {}

      final log = talker.history.last;
      expect(log.generateTextMessage(), contains('failed'));
    });
    test('mutationReset', () async {
      container.listen(testProvider, (previous, next) {});
      container.listen(TestNotifier.mutation, (previous, next) {});

      await TestNotifier.mutation.run(container, (transaction) async {
        return transaction.get(testProvider.notifier).changeState("Some State");
      });

      TestNotifier.mutation.reset(container);

      final log = talker.history.last;
      expect(log.generateTextMessage(), contains('reset'));
    });
    test('mutationStart', () async {
      container.listen(testProvider, (previous, next) {});
      container.listen(TestNotifier.mutation, (previous, next) {});

      await TestNotifier.mutation.run(container, (transaction) async {
        return transaction
            .get(testProvider.notifier)
            .changeState("Some mutated state");
      });

      final logs = talker.history.map((e) => e.generateTextMessage());
      expect(logs, anyElement(contains('started')));
    });
    test('mutationSuccess', () async {
      container.listen(testProvider, (previous, next) {});
      container.listen(TestNotifier.mutation, (previous, next) {});

      await TestNotifier.mutation.run(container, (transaction) async {
        return transaction
            .get(testProvider.notifier)
            .changeState("Some mutated state");
      });

      final logs = talker.history.map((e) => e.generateTextMessage());
      expect(logs, anyElement(contains('succeeded')));
      expect(
        logs,
        anyElement(contains("Mutated Initial State to Some mutated state!")),
      );
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

        container.listen(familyProvider(arg), (previous, next) {});

        container.read(familyProvider(arg));
        container.read(familyProvider(arg).notifier).changeState("999");

        final generateTextMessage = talker.history.last.generateTextMessage();
        expect(generateTextMessage, contains("($arg)"));
        expect(generateTextMessage, contains("3"));
      });
      test('didDisposeProvider', () async {
        const arg = "99";
        container.read(familyProvider(arg));
        await container.pump();
        final generateTextMessage = talker.history.last.generateTextMessage();
        expect(generateTextMessage, contains("($arg)"));
        expect(generateTextMessage, contains('disposed'));
      });
      test('providerDidFail', () async {
        const arg = "99";
        final sub = container.listen(
          familyErrorProvider(arg).future,
          (previous, next) {},
        );

        try {
          final _ = await sub.read();
        } catch (_) {
        } finally {
          sub.close();
        }

        final log = talker.history.first.generateTextMessage();
        expect(log, contains("($arg)"));
        expect(log, contains('failed'));
      });
      test('providerDidFail with filter', () async {
        talkerRiverpodObserver = TalkerRiverpodObserver(
          talker: talker,
          settings: TalkerRiverpodLoggerSettings(
            enabled: true,
            printProviderDisposed: true,
            didFailFilter: (error) {
              if (error is Exception) return false;
              return true;
            },
          ),
        );
        container = ProviderContainer.test(
          observers: [talkerRiverpodObserver],
          retry: (retryCount, error) => null,
        );

        final sub = container.listen(errorProvider.future, (previous, next) {});
        try {
          await sub.read();
        } catch (_) {
        } finally {
          sub.close();
        }

        final log = talker.history;
        expect(log.whereType<RiverpodFailLog>(), isEmpty);
      });
      test('mutationError', () async {
        const arg = "99";
        container.listen(familyProvider(arg), (previous, next) {});
        container.listen(FamilyTestNotifier.failMutation, (previous, next) {});

        try {
          await FamilyTestNotifier.failMutation.run(container, (ref) async {
            ref.get(familyProvider(arg).notifier).fail();
          });
        } catch (_) {}

        final log = talker.history.last;
        expect(log.generateTextMessage(), contains('failed'));
      });
      test('mutationReset', () async {
        const arg = "99";
        container.listen(familyProvider(arg), (previous, next) {});
        container.listen(FamilyTestNotifier.mutation, (previous, next) {});

        await FamilyTestNotifier.mutation.run(container, (ref) async {
          return ref
              .get(familyProvider(arg).notifier)
              .changeState("Some State");
        });

        FamilyTestNotifier.mutation.reset(container);

        final log = talker.history.last;
        expect(log.generateTextMessage(), contains('reset'));
      });
      test('mutationStart', () async {
        const arg = "99";
        container.listen(familyProvider(arg), (previous, next) {});
        container.listen(FamilyTestNotifier.mutation, (previous, next) {});

        await FamilyTestNotifier.mutation.run(container, (transaction) async {
          return transaction
              .get(familyProvider(arg).notifier)
              .changeState("Some mutated state");
        });

        final logs = talker.history.map((e) => e.generateTextMessage());
        expect(logs, anyElement(contains('started')));
      });
      test('mutationSuccess', () async {
        const arg = "99";
        container.listen(familyProvider(arg), (previous, next) {});
        container.listen(FamilyTestNotifier.mutation, (previous, next) {});

        await FamilyTestNotifier.mutation.run(container, (transaction) async {
          return transaction
              .get(familyProvider(arg).notifier)
              .changeState("Some mutated state");
        });

        final logs = talker.history.map((e) => e.generateTextMessage());
        expect(logs, anyElement(contains('succeeded')));
        expect(logs, anyElement(contains("Mutated 2 to 18!")));
      });
    });

    group('with different log levels', () {
      setUp(() {
        talker = Talker(
          settings: TalkerSettings(useConsoleLogs: false),
          logger: TalkerLogger(
            settings: TalkerLoggerSettings(level: LogLevel.error),
          ),
        );
        talkerRiverpodObserver = TalkerRiverpodObserver(
          talker: talker,
          settings: TalkerRiverpodLoggerSettings(
            enabled: true,
            printMutationReset: true,
            mutationResetLevel: LogLevel.warning,
          ),
        );

        container = ProviderContainer.test(
          observers: [talkerRiverpodObserver],
          retry: (retryCount, error) => null,
        );
      });

      test('didAddProvider', () {
        container.read(testProvider);
        expect(talker.history, isEmpty);
      });
      test('didUpdateProvider', () async {
        final input = 'Updated State';

        container.listen(testProvider, (previous, next) {});
        container.read(testProvider);
        container.read(testProvider.notifier).changeState(input);

        expect(talker.history, isEmpty);
      });
      test('didDisposeProvider', () async {
        container.read(testProvider);

        await container.pump();

        expect(talker.history, isEmpty);
      });
      test('providerDidFail', () async {
        final sub = container.listen(errorProvider.future, (previous, next) {});
        try {
          final _ = await sub.read();
        } catch (_) {
        } finally {
          sub.close();
        }
        final log = talker.history.single;
        expect(log.generateTextMessage(), contains('failed'));
      });
      test('mutationError', () async {
        container.listen(testProvider, (previous, next) {});
        container.listen(TestNotifier.failMutation, (previous, next) {});

        try {
          await TestNotifier.failMutation.run(container, (transaction) async {
            transaction.get(testProvider.notifier).fail();
          });
        } catch (_) {}

        final log = talker.history.single;
        expect(log.generateTextMessage(), contains('failed'));
      });
      test('mutationReset', () async {
        container.listen(testProvider, (previous, next) {});
        container.listen(TestNotifier.mutation, (previous, next) {});

        await TestNotifier.mutation.run(container, (transaction) async {
          return transaction
              .get(testProvider.notifier)
              .changeState("Some State");
        });

        TestNotifier.mutation.reset(container);

        final logs = talker.history;
        expect(logs, isEmpty);
      });
      test('mutationStart', () async {
        container.listen(testProvider, (previous, next) {});
        container.listen(TestNotifier.mutation, (previous, next) {});

        await TestNotifier.mutation.run(container, (transaction) async {
          return transaction
              .get(testProvider.notifier)
              .changeState("Some mutated state");
        });

        expect(talker.history, isEmpty);
      });
      test('mutationSuccess', () async {
        container.listen(testProvider, (previous, next) {});
        container.listen(TestNotifier.mutation, (previous, next) {});

        await TestNotifier.mutation.run(container, (transaction) async {
          return transaction
              .get(testProvider.notifier)
              .changeState("Some mutated state");
        });

        expect(talker.history, isEmpty);
      });
    });
  });
}

class TestNotifier extends Notifier<String> {
  @override
  String build() {
    return "Initial State";
  }

  static final mutation = Mutation<String>();
  String changeState(String newState) {
    final old = state;
    state = newState;
    return "Mutated $old to $state!";
  }

  static final failMutation = Mutation<void>();
  void fail() {
    throw Exception("Failure in TestNotifier");
  }
}

final testProvider = NotifierProvider.autoDispose<TestNotifier, String>(
  TestNotifier.new,
);

class FamilyTestNotifier extends Notifier<int> {
  FamilyTestNotifier(this.arg);
  final String arg;

  @override
  int build() {
    return arg.length;
  }

  static final mutation = Mutation<String>();

  String changeState(String newState) {
    final old = state;
    state = newState.length;
    return "Mutated $old to $state!";
  }

  static final failMutation = Mutation<void>();
  void fail() {
    throw Exception("Failure in FamilyTestNotifier with arg: $arg");
  }
}

final familyProvider = NotifierProvider.family
    .autoDispose<FamilyTestNotifier, int, String>(FamilyTestNotifier.new);

final familyErrorProvider = FutureProvider.family.autoDispose<String, String>(
  (ref, arg) =>
      throw Exception("Exception from familyErrorProvider with arg: $arg"),
);

final errorProvider = FutureProvider.autoDispose<String>(
  (ref) => throw Exception("Exception from errorProvider"),
);
