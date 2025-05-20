import 'package:bloc/bloc.dart';
import 'package:talker/talker.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

/// [Bloc] event log model
class BlocEventLog extends TalkerLog {
  BlocEventLog({
    required this.bloc,
    required this.event,
    required this.settings,
  }) : super(settings.printEventFullData
            ? '${bloc.runtimeType} receive event:\n$event'
            : '${bloc.runtimeType} receive event: ${event.runtimeType}');

  final Bloc bloc;
  final Object? event;
  final TalkerBlocLoggerSettings settings;

  @override
  String get key => TalkerLogType.blocEvent.key;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    return sb.toString();
  }
}

/// [Bloc] state transition log model
class BlocStateLog extends TalkerLog {
  BlocStateLog({
    required this.bloc,
    required this.transition,
    required this.settings,
  }) : super('${bloc.runtimeType} with event ${transition.event.runtimeType}'
            '\nCURRENT state: ${_formatCurrentState(transition.currentState, settings)}'
            '\nNEXT state: ${_formatNextState(transition.nextState, settings)}');

  String _formatCurrentState(Object? currentState, TalkerBlocLoggerSettings settings) {
    return settings.printStateFullData ? '\n$currentState' : currentState.runtimeType.toString();
  }

  String _formatNextState(Object? nextState, TalkerBlocLoggerSettings settings) {
    return settings.printStateFullData ? '\n$nextState' : nextState.runtimeType.toString();
  }
  final Bloc bloc;
  final Transition transition;
  final TalkerBlocLoggerSettings settings;

  @override
  String get key => TalkerLogType.blocTransition.key;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    return sb.toString();
  }
}

/// [Bloc] state changed log model
class BlocChangeLog extends TalkerLog {
  BlocChangeLog({
    required this.bloc,
    required this.change,
    required this.settings,
  }) : super('${bloc.runtimeType} changed'
            '\nCURRENT state: ${_formatStateDetails(state: change.currentState, printFullData: settings.printStateFullData)}'
            '\nNEXT state: ${_formatStateDetails(state: change.nextState, printFullData: settings.printStateFullData)}');

  final BlocBase bloc;
  final Change change;
  final TalkerBlocLoggerSettings settings;

  @override
  String get key => TalkerLogType.blocTransition.key;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    return sb.toString();
  }
}

/// [Bloc] created log model
class BlocCreateLog extends TalkerLog {
  BlocCreateLog({
    required this.bloc,
  }) : super('${bloc.runtimeType} created');

  final BlocBase bloc;

  @override
  String? get key => TalkerLogType.blocCreate.key;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    return sb.toString();
  }
}

/// [Bloc] closed log model
class BlocCloseLog extends TalkerLog {
  BlocCloseLog({
    required this.bloc,
  }) : super('${bloc.runtimeType} closed');

  final BlocBase bloc;

  @override
  String? get key => TalkerLogType.blocClose.key;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    return sb.toString();
  }
}
