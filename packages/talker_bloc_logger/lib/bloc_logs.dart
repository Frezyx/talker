import 'package:bloc/bloc.dart';
import 'package:talker/talker.dart';

class BlocEventLog extends TalkerLog {
  BlocEventLog(Bloc bloc, Object? event) : super(_createMessage(bloc, event));

  @override
  AnsiPen get pen => AnsiPen()..xterm(51);

  @override
  String get title => 'BLOC';

  static String _createMessage(Bloc bloc, Object? event) {
    return 'Event recive in ${bloc.runtimeType} event: $event';
  }
}

class BlocStateLog extends TalkerLog {
  BlocStateLog(Bloc bloc, Transition transition)
      : super(_createMessage(bloc, transition));

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  @override
  String get title => 'BLOC';

  static String _createMessage(Bloc bloc, Transition transition) {
    return '\n${'TRANSITION in ${bloc.runtimeType} with event ${transition.event.runtimeType}'}\n${'CURRENT state: ${transition.currentState.runtimeType}'}\n${'NEXT state: ${transition.nextState.runtimeType}'}';
  }
}
