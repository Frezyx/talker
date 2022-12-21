import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    GetIt.instance<Talker>().logTyped(BlocEventLog(bloc, event));
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    GetIt.instance<Talker>().logTyped(BlocStateLog(bloc, transition));
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    GetIt.instance<Talker>()
        .handle(error, stackTrace, '🚨 [BLOC] Error in ${bloc.runtimeType}');
  }
}

class BlocEventLog extends FlutterTalkerLog {
  BlocEventLog(Bloc bloc, Object? event) : super(_createMessage(bloc, event));

  @override
  AnsiPen get pen => AnsiPen()..xterm(51);

  @override
  Color get color => const Color(0xFF00FFFF);

  @override
  String get title => 'BLOC';

  static String _createMessage(Bloc bloc, Object? event) {
    return 'Event recive in ${bloc.runtimeType} event: $event';
  }
}

class BlocStateLog extends FlutterTalkerLog {
  BlocStateLog(Bloc bloc, Transition transition)
      : super(_createMessage(bloc, transition));

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  @override
  Color get color => const Color(0xFF00FFAF);

  @override
  String get title => 'BLOC';

  static String _createMessage(Bloc bloc, Transition transition) {
    return '${'TRANSITION in ${bloc.runtimeType} with event ${transition.event.runtimeType}'}\n${'CURRENT state: ${transition.currentState.runtimeType}'}\n${'NEXT state: ${transition.nextState.runtimeType}'}';
  }
}
