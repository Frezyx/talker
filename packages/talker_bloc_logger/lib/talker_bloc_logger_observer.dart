import 'package:bloc/bloc.dart';
import 'package:talker/talker.dart';
import 'package:talker_bloc_logger/bloc_logs.dart';

class TalkerBlocObserver extends BlocObserver {
  TalkerBlocObserver({
    Talker? talker,
  }) {
    _talker = talker ?? Talker();
  }

  late TalkerInterface _talker;

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _talker.logTyped(BlocEventLog(bloc, event));
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _talker.logTyped(BlocStateLog(bloc, transition));
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _talker.error('${bloc.runtimeType}', error, stackTrace);
  }
}
