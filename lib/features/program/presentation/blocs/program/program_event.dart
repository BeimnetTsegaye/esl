part of 'program_bloc.dart';

abstract class ProgramEvent extends Equatable {
  const ProgramEvent();

  @override
  List<Object> get props => [];
}

class LoadPrograms extends ProgramEvent {
  const LoadPrograms();

  @override
  List<Object> get props => [];
}

class RefreshPrograms extends ProgramEvent {
  const RefreshPrograms();

  @override
  List<Object> get props => [];
}

class SelectProgram extends ProgramEvent {
  final Program program;

  const SelectProgram(this.program);

  @override
  List<Object> get props => [program];
}

class ClearSelectedProgram extends ProgramEvent {
  const ClearSelectedProgram();

  @override
  List<Object> get props => [];
}
