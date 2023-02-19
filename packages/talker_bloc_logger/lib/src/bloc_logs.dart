import 'package:bloc/bloc.dart';
import 'package:talker/talker.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

/// [Bloc] event log model
class BlocEventLog extends TalkerLog {
  BlocEventLog({
    required this.bloc,
    required this.event,
    required this.settings,
  }) : super('');

  final Bloc bloc;
  final Object? event;
  final TalkerBlocLoggerSettings settings;

  @override
  AnsiPen get pen => AnsiPen()..xterm(51);

  @override
  String get title => 'BLOC';

  @override
  String generateTextMessage() {
    return _createMessage();
  }

  String _createMessage() {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime);
    if (settings.printEventFullData) {
      sb.write('\n${bloc.runtimeType} recive event:\n$event');
    } else {
      sb.write('\n${bloc.runtimeType} recvie event: ${event.runtimeType}');
    }
    return sb.toString();
  }
}

/// [Bloc] state log model
class BlocStateLog extends TalkerLog {
  BlocStateLog({
    required this.bloc,
    required this.transition,
    required this.settings,
  }) : super('');

  final Bloc bloc;
  final Transition transition;
  final TalkerBlocLoggerSettings settings;

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  @override
  String get title => 'BLOC';

  @override
  String generateTextMessage() {
    return _createMessage();
  }

  String _createMessage() {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime);
    sb.write(
        '\nTRANSITION in ${bloc.runtimeType} with event ${transition.event.runtimeType}');
    sb.write(
        '\n${'CURRENT state: ${settings.printStateFullData ? '\n${transition.currentState}' : transition.currentState.runtimeType}'}');
    sb.write(
        '\n${'NEXT state: ${settings.printStateFullData ? '\n${transition.nextState}' : transition.nextState.runtimeType}'}');
    return sb.toString();
  }
}
