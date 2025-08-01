import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talker/talker.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

/// [BLoC] logger on [Talker] base
///
/// [talker] field is the current [Talker] instance.
/// Provide your instance if your application uses [Talker] as the default logger
/// Common Talker instance will be used by default
class TalkerBlocObserver extends BlocObserver {
  TalkerBlocObserver({
    Talker? talker,
    this.settings = const TalkerBlocLoggerSettings(),
  }) {
    _talker = talker ?? Talker();
    _talker.settings.registerKeys(
      [
        TalkerKey.blocEvent,
        TalkerKey.blocTransition,
        TalkerKey.blocCreate,
        TalkerKey.blocClose,
      ],
    );
  }

  late Talker _talker;
  final TalkerBlocLoggerSettings settings;

  @override
  @mustCallSuper
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (!settings.enabled || !settings.printEvents) {
      return;
    }
    final accepted = settings.eventFilter?.call(bloc, event) ?? true;
    if (!accepted) {
      return;
    }
    _talker.logCustom(
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
    if (!settings.enabled || !settings.printTransitions) {
      return;
    }
    final accepted = settings.transitionFilter?.call(bloc, transition) ?? true;
    if (!accepted) {
      return;
    }
    _talker.logCustom(BlocStateLog(
      bloc: bloc,
      transition: transition,
      settings: settings,
    ));
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (!settings.enabled || !settings.printChanges) {
      return;
    }
    _talker.logCustom(
      BlocChangeLog(
        bloc: bloc,
        change: change,
        settings: settings,
      ),
    );
  }

  @override
  @mustCallSuper
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _talker.error('${bloc.runtimeType}', error, stackTrace);
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (!settings.enabled || !settings.printCreations) {
      return;
    }
    _talker.logCustom(BlocCreateLog(bloc: bloc));
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (!settings.enabled || !settings.printClosings) {
      return;
    }
    _talker.logCustom(BlocCloseLog(bloc: bloc));
  }
}
