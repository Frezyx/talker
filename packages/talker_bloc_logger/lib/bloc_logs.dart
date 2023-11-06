import 'package:bloc/bloc.dart';
import 'package:talker/talker.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

/// [Bloc] event log model
class BlocEventLog extends TalkerLog {
  BlocEventLog({
    required this.bloc,
    required this.event,
    required this.settings,
  }) : super(settings.printEventFullData
            ? '${bloc.runtimeType} receive event:\n$event'
            : '${bloc.runtimeType} receive event: ${event.runtimeType}');

  final Bloc bloc;
  final Object? event;
  final TalkerBlocLoggerSettings settings;

  @override
  AnsiPen get pen => AnsiPen()..xterm(51);

  @override
  String get title => TalkerKey.blocEvent.title;

  @override
  String generateTextMessage() {
    return _createMessage();
  }

  String _createMessage() {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime);
    sb.write('\n$message');
    return sb.toString();
  }
}

/// [Bloc] state transition log model
class BlocStateLog extends TalkerLog {
  BlocStateLog({
    required this.bloc,
    required this.transition,
    required this.settings,
  }) : super('${bloc.runtimeType} with event ${transition.event.runtimeType}');

  final Bloc bloc;
  final Transition transition;
  final TalkerBlocLoggerSettings settings;

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  @override
  String get title => TalkerKey.blocTransition.title;

  @override
  String generateTextMessage() {
    return _createMessage();
  }

  String _createMessage() {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime);
    sb.write('\n$message');
    sb.write(
        '\n${'CURRENT state: ${settings.printStateFullData ? '\n${transition.currentState}' : transition.currentState.runtimeType}'}');
    sb.write(
        '\n${'NEXT state: ${settings.printStateFullData ? '\n${transition.nextState}' : transition.nextState.runtimeType}'}');
    return sb.toString();
  }
}

/// [Bloc] state changed log model
class BlocChangeLog extends TalkerLog {
  BlocChangeLog({
    required this.bloc,
    required this.change,
    required this.settings,
  }) : super('${bloc.runtimeType} changed');

  final BlocBase bloc;
  final Change change;
  final TalkerBlocLoggerSettings settings;

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  @override
  String get title => TalkerKey.blocTransition.title;

  @override
  String generateTextMessage() {
    return _createMessage();
  }

  String _createMessage() {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime);
    sb.write('\n$message');
    sb.write(
        '\n${'CURRENT state: ${settings.printStateFullData ? '\n${change.currentState}' : change.currentState.runtimeType}'}');
    sb.write(
        '\n${'NEXT state: ${settings.printStateFullData ? '\n${change.nextState}' : change.nextState.runtimeType}'}');
    return sb.toString();
  }
}
