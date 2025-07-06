import 'package:equatable/equatable.dart';
import 'package:esl/features/program/domain/entities/program.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'selected_program_event.dart';
part 'selected_program_state.dart';

class SelectedProgramBloc extends Bloc<SelectedProgramEvent, SelectedProgramState> {
  SelectedProgramBloc() : super(const SelectedProgramInitial()) {
    on<SelectProgram>(_onSelectProgram);
    on<ClearSelectedProgram>(_onClearSelectedProgram);
  }

  void _onSelectProgram(
    SelectProgram event,
    Emitter<SelectedProgramState> emit,
  ) {
    emit(SelectedProgramLoaded(event.program));
  }

  void _onClearSelectedProgram(
    ClearSelectedProgram event,
    Emitter<SelectedProgramState> emit,
  ) {
    emit(const SelectedProgramInitial());
  }
} 