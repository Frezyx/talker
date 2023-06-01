import 'package:bloc/bloc.dart';

class TalkerBlocLoggerSettings {
  const TalkerBlocLoggerSettings({
    this.enabled = true,
    this.printEventFullData = true,
    this.printStateFullData = true,
    this.transitionFilter,
    this.eventFilter,
  });

  final bool enabled;
  final bool printEventFullData;
  final bool printStateFullData;
  final bool Function(Bloc bloc, Transition transition)? transitionFilter;
  final bool Function(Bloc bloc, Object? event)? eventFilter;
}
