part of 'selected_program_bloc.dart';

abstract class SelectedProgramEvent extends Equatable {
  const SelectedProgramEvent();

  @override
  List<Object> get props => [];
}

class SelectProgram extends SelectedProgramEvent {
  final Program program;

  const SelectProgram(this.program);

  @override
  List<Object> get props => [program];
}

class ClearSelectedProgram extends SelectedProgramEvent {
  const ClearSelectedProgram();

  @override
  List<Object> get props => [];
} 