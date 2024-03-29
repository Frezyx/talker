// ignore_for_file: invalid_use_of_protected_member, override_on_non_overriding_member

import 'package:bloc/bloc.dart';
import 'package:talker/talker.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerBlocObserver tests', () {
    late TalkerBlocObserver talkerBlocObserver;
    late Talker talker;
    late TestBloc testBloc;

    setUp(() {
      talker = Talker(settings: TalkerSettings(useConsoleLogs: false));
      talkerBlocObserver = TalkerBlocObserver(
        settings: TalkerBlocLoggerSettings(enabled: true),
        talker: talker,
      );
      Bloc.observer = talkerBlocObserver;
      testBloc = TestBloc();
    });

    test('onEvent full data', () {
      final expectedEvent = 'test_event';
      testBloc.add(expectedEvent);
      expect(
        talker.history.first.generateTextMessage(),
        contains(expectedEvent),
      );
    });

    test('onEvent split data', () {
      talkerBlocObserver = TalkerBlocObserver(
        settings: TalkerBlocLoggerSettings(
          enabled: true,
          printEventFullData: false,
        ),
        talker: talker,
      );
      Bloc.observer = talkerBlocObserver;
      testBloc = TestBloc();

      final expectedEvent = 'test_event';
      testBloc.add(expectedEvent);
      expect(
        talker.history.first.generateTextMessage(),
        contains(expectedEvent.runtimeType.toString()),
      );
    });

    test('onTransition full data', () async {
      final expectedEvent = 'test_event';
      final expectedState = 'test_state';
      testBloc.add(expectedEvent);
      await Future.delayed(const Duration(milliseconds: 10));
      final log = talker.history.last;
      expect(log.generateTextMessage(), contains(expectedState));
    });

    test('onTransition split data', () async {
      talkerBlocObserver = TalkerBlocObserver(
        settings: TalkerBlocLoggerSettings(
          enabled: true,
          printEventFullData: false,
          printStateFullData: false,
        ),
        talker: talker,
      );
      Bloc.observer = talkerBlocObserver;
      testBloc = TestBloc();

      final expectedEvent = 'test_event';
      final expectedState = 'test_state';

      testBloc.add(expectedEvent);
      await Future.delayed(const Duration(milliseconds: 10));
      final log = talker.history.last;
      expect(
        log.generateTextMessage(),
        contains(expectedState.runtimeType.toString()),
      );
    });

    test('onError ', () {
      final expectedError = Exception('Test error');
      final expectedStackTrace = StackTrace.current;
      testBloc.addError(expectedError, expectedStackTrace);
      expect(
        talker.history.last.generateTextMessage(),
        contains('error'),
      );
    });

    test('onChange ', () async {
      final talkerBlocObserver = TalkerBlocObserver(
        settings: TalkerBlocLoggerSettings(enabled: true, printChanges: true),
        talker: talker,
      );
      Bloc.observer = talkerBlocObserver;
      testBloc = TestBloc();

      final expectedEvent = 'test_event';
      final expectedState = 'test_state';
      testBloc.add(expectedEvent);
      await Future.delayed(const Duration(milliseconds: 10));
      final log = talker.history.last;
      expect(log.generateTextMessage(), contains(expectedState));
    });

    test('oncreate ', () async {
      final talkerBlocObserver = TalkerBlocObserver(
        settings: TalkerBlocLoggerSettings(enabled: true, printCreations: true),
        talker: talker,
      );
      Bloc.observer = talkerBlocObserver;
      testBloc = TestBloc();

      await Future.delayed(const Duration(milliseconds: 10));
      final log = talker.history.last;
      expect(log.generateTextMessage(), contains('created'));
    });

    test('onClose ', () async {
      final talkerBlocObserver = TalkerBlocObserver(
        settings: TalkerBlocLoggerSettings(enabled: true, printClosings: true),
        talker: talker,
      );
      Bloc.observer = talkerBlocObserver;
      testBloc = TestBloc();
      await testBloc.close();

      expect(talker.history, isNotEmpty);
      expect(talker.history.last.generateTextMessage(), contains('closed'));
    });
  });
}

class TestBloc extends Bloc<String, String> {
  TestBloc() : super('') {
    on<String>((event, emit) {
      emit('test_state');
    });
  }
}
