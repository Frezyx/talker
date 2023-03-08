import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talker/talker.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

/// [BLoC] logger on [Talker] base
///
/// [talker] filed is current [Talker] instance.
/// Provide your instance if your application used [Talker] as default logger
/// Commont Talker instance will be used by default
class TalkerBlocObserver extends BlocObserver {
  TalkerBlocObserver({
    Talker? talker,
    this.settings = const TalkerBlocLoggerSettings(),
  }) {
    _talker = talker ?? Talker();
    _talker.registerAddon(
      code: TalkerOriginalAddons.talkerBlocLogger.code,
      addon: this,
    );
  }

  late TalkerInterface _talker;
  final TalkerBlocLoggerSettings settings;

  @override
  @mustCallSuper
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (!settings.enabled) {
      return;
    }
    final accepted = settings.eventFilter?.call(bloc, event) ?? true;
    if (!accepted) {
      return;
    }
    _talker.logTyped(
      BlocEventLog(
        bloc: bloc,
        event: event,
        settings: settings,
      ),
    );
  }

  @override
  @mustCallSuper
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (!settings.enabled) {
      return;
    }
    final accepted = settings.transitionFilter?.call(bloc, transition) ?? true;
    if (!accepted) {
      return;
    }
    _talker.logTyped(BlocStateLog(
      bloc: bloc,
      transition: transition,
      settings: settings,
    ));
  }

  @override
  @mustCallSuper
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _talker.error('${bloc.runtimeType}', error, stackTrace);
  }
}
