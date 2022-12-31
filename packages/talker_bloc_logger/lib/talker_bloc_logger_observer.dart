import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:talker/talker.dart';
import 'package:talker_bloc_logger/bloc_logs.dart';

/// [BLoC] logger on [Talker] base
///
/// [talker] filed is current [Talker] instance.
/// Provide your instance if your application used [Talker] as default logger
/// Commont Talker instance will be used by default
class TalkerBlocObserver extends BlocObserver {
  TalkerBlocObserver({
    Talker? talker,
  }) {
    _talker = talker ?? Talker();
  }

  late TalkerInterface _talker;

  @override
  @mustCallSuper
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _talker.logTyped(BlocEventLog(bloc, event));
  }

  @override
  @mustCallSuper
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _talker.logTyped(BlocStateLog(bloc, transition));
  }

  @override
  @mustCallSuper
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _talker.error('${bloc.runtimeType}', error, stackTrace);
  }
}
