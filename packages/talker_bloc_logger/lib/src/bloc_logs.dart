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
    if (settings.printEventFullData) {
      return '${bloc.runtimeType} recive event:\n$event';
    }
    return '${bloc.runtimeType} recvie event: ${event.runtimeType}';
  }
}

/// [Bloc] state log model
class BlocStateLog extends TalkerLog {
  BlocStateLog(Bloc bloc, Transition transition)
      : super(_createMessage(bloc, transition));

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  @override
  String get title => 'BLOC';

  static String _createMessage(Bloc bloc, Transition transition) {
    final sb = StringBuffer();
    sb.write(
        '\n${'TRANSITION in ${bloc.runtimeType} with event ${transition.event.runtimeType}'}');
    sb.write('\n${'CURRENT state: ${transition.currentState.runtimeType}'}');
    sb.write('\n${'NEXT state: ${transition.nextState.runtimeType}'}');
    return sb.toString();
  }
}
