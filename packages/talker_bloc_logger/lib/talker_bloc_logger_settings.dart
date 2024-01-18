import 'package:bloc/bloc.dart';

class TalkerBlocLoggerSettings {
  const TalkerBlocLoggerSettings({
    this.enabled = true,
    this.printEvents = true,
    this.printTransitions = true,
    this.printChanges = false,
    this.printEventFullData = true,
    this.printStateFullData = true,
    this.printCreations = false,
    this.printClosings = false,
    this.transitionFilter,
    this.eventFilter,
  });

  final bool enabled;
  final bool printEvents;
  final bool printTransitions;
  final bool printChanges;
  final bool printEventFullData;
  final bool printStateFullData;
  final bool printCreations;
  final bool printClosings;
  final bool Function(Bloc bloc, Transition transition)? transitionFilter;
  final bool Function(Bloc bloc, Object? event)? eventFilter;
}
