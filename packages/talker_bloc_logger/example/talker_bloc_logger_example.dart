import 'package:bloc/bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

class SomethingBloc extends Bloc<SomethingEvent, SomethingState> {
  SomethingBloc() : super(SomethingInitial()) {
    on<LoadSomething>((event, emit) {
      emit(SomethingLoading());
      emit(SomethingLoaded());
    });
  }
}

abstract class SomethingEvent {}

class LoadSomething extends SomethingEvent {}

abstract class SomethingState {}

class SomethingInitial extends SomethingState {}

class SomethingLoading extends SomethingState {}

class SomethingLoaded extends SomethingState {}

void main() {
  Bloc.observer = TalkerBlocObserver();
  final somethingBloc = SomethingBloc();
  somethingBloc.add(LoadSomething());
}
