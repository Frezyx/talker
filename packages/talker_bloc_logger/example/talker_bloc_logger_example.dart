import 'package:bloc/bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

void main() async {
  Bloc.observer = TalkerBlocObserver(
    settings: TalkerBlocLoggerSettings(
      enabled: true,
      printEventFullData: false,
      printStateFullData: false,
      printChanges: true,
      printClosings: true,
      printCreations: true,
      printEvents: true,
      printTransitions: true,
      // If you want log only AuthBloc transitions
      transitionFilter: (bloc, transition) =>
          bloc.runtimeType.toString() == 'AuthBloc',
      // If you want log only AuthBloc events
      eventFilter: (bloc, event) => bloc.runtimeType.toString() == 'AuthBloc',
    ),
  );
  final somethingBloc = SomethingBloc();
  somethingBloc.add(LoadSomething(LoadSomethingCase.successful));
  await Future.delayed(const Duration(milliseconds: 300));
  somethingBloc.add(LoadSomething(LoadSomethingCase.failure));
}

enum LoadSomethingCase { successful, failure }

class SomethingBloc extends Bloc<SomethingEvent, SomethingState> {
  SomethingBloc() : super(SomethingInitial()) {
    on<LoadSomething>((event, emit) {
      emit(SomethingLoading());
      if (event.loadCase == LoadSomethingCase.successful) {
        emit(SomethingLoaded());
        return;
      }
      throw Exception('Load something failure');
    });
  }
}

abstract class SomethingEvent {}

class LoadSomething extends SomethingEvent {
  LoadSomething(this.loadCase);

  final LoadSomethingCase loadCase;
}

abstract class SomethingState {}

class SomethingInitial extends SomethingState {}

class SomethingLoading extends SomethingState {}

class SomethingLoaded extends SomethingState {}

class SomethingLoadingFailure extends SomethingState {
  SomethingLoadingFailure(this.exception);
  final Object? exception;
}
