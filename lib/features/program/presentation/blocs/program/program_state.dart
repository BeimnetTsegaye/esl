part of 'program_bloc.dart';

abstract class ProgramState extends Equatable {
  const ProgramState();

  @override
  List<Object?> get props => [];
}

class ProgramInitial extends ProgramState {}

class ProgramLoading extends ProgramState {
  final List<Program> fakePrograms = [
    Program(
      id: '1',
      name: 'Marine Engineering',
      description: 'Batch A',
      courses: List.empty(),
      directorId: '1',
    ),
    Program(
      id: '1',  
      name: 'Marine Engineering',
      description: 'Batch A',
      courses: List.empty(),
      directorId: '1',
    ),
    Program(
      id: '1',
      name: 'Marine Engineering',
      description: 'Batch A',
      courses: List.empty(),
      directorId: '1',
    ),
    Program(
      id: '1',
      name: 'Marine Engineering',
      description: 'Batch A',
      courses: List.empty(),
      directorId: '1',
    ),
  ];
}

class ProgramLoaded extends ProgramState {
  final List<Program> programs;
  final Program? selectedProgram;

  const ProgramLoaded(this.programs, {this.selectedProgram});

  @override
  List<Object?> get props => [programs, selectedProgram];
}

class ProgramError extends ProgramState {
  final String message;
  final Program? selectedProgram;

  const ProgramError(this.message, {this.selectedProgram});

  @override
  List<Object?> get props => [message, selectedProgram];
}

class ProgramEmpty extends ProgramState {
  final String message;
  final Program? selectedProgram;

  const ProgramEmpty(this.message, {this.selectedProgram});

  @override
  List<Object?> get props => [message, selectedProgram];
}
