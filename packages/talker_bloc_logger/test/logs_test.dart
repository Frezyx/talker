import 'package:bloc/bloc.dart';
import 'package:talker/talker.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:test/test.dart';

class FakeBloc extends Bloc<String, String> {
  FakeBloc() : super('');
}

class FakeTransition extends Transition {
  FakeTransition({required currentState, required event, required nextState})
      : super(currentState: currentState, event: event, nextState: nextState);
}

class FakeChange extends Change {
  FakeChange({required currentState, required nextState})
      : super(currentState: currentState, nextState: nextState);
}

void main() {
  group('BlocEventLog', () {
    test('Constructor should set values correctly', () {
      final fakeBloc = FakeBloc();
      final fakeEvent = Object();
      final fakeSettings = TalkerBlocLoggerSettings();

      final log = BlocEventLog(
          bloc: fakeBloc, event: fakeEvent, settings: fakeSettings);

      expect(log.bloc, fakeBloc);
      expect(log.event, fakeEvent);
      expect(log.settings, fakeSettings);
      expect(log.key, TalkerLogType.blocEvent.key);
    });
  });

  group('BlocStateLog', () {
    test('Constructor should set values correctly', () {
      final fakeBloc = FakeBloc();
      final fakeTransition = FakeTransition(
        currentState: '',
        event: '',
        nextState: '',
      );
      final fakeSettings = TalkerBlocLoggerSettings();

      final log = BlocStateLog(
          bloc: fakeBloc, transition: fakeTransition, settings: fakeSettings);

      expect(log.bloc, fakeBloc);
      expect(log.transition, fakeTransition);
      expect(log.settings, fakeSettings);
      expect(log.key, TalkerLogType.blocTransition.key);
    });
  });

  group('BlocChangeLog', () {
    test('Constructor should set values correctly', () {
      final fakeBloc = FakeBloc();
      final fakeChange = FakeChange(currentState: '', nextState: '');
      final fakeSettings = TalkerBlocLoggerSettings();

      final log = BlocChangeLog(
        bloc: fakeBloc,
        change: fakeChange,
        settings: fakeSettings,
      );

      expect(log.bloc, fakeBloc);
      expect(log.change, fakeChange);
      expect(log.settings, fakeSettings);
      expect(log.key, TalkerLogType.blocTransition.key);

      final message = log.generateTextMessage();
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('change'));
    });
  });

  group('BlocCreateLog', () {
    test('Constructor should set values correctly', () {
      final fakeBloc = FakeBloc();

      final log = BlocCreateLog(bloc: fakeBloc);

      expect(log.bloc, fakeBloc);
      expect(log.key, TalkerLogType.blocCreate.key);

      final message = log.generateTextMessage();
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('create'));
    });
  });

  group('BlocCloseLog', () {
    test('Constructor should set values correctly', () {
      final fakeBloc = FakeBloc();

      final log = BlocCloseLog(bloc: fakeBloc);

      expect(log.bloc, fakeBloc);
      expect(log.key, TalkerLogType.blocClose.key);

      final message = log.generateTextMessage();
      expect(message, isA<String>());
      expect(message, isNotEmpty);
      expect(message, contains('close'));
    });
  });
}
