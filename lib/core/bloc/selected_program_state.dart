part of 'selected_program_bloc.dart';

abstract class SelectedProgramState extends Equatable {
  const SelectedProgramState();

  @override
  List<Object> get props => [];
}

class SelectedProgramInitial extends SelectedProgramState {
  const SelectedProgramInitial();

  @override
  List<Object> get props => [];
}

class SelectedProgramLoaded extends SelectedProgramState {
  final Program program;

  const SelectedProgramLoaded(this.program);

  @override
  List<Object> get props => [program];
} 