import 'package:equatable/equatable.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/program/domain/entities/program.dart';
import 'package:esl/features/program/domain/usecases/get_programs_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'program_event.dart';
part 'program_state.dart';

class ProgramBloc extends Bloc<ProgramEvent, ProgramState> {
  final GetProgramsUseCase _getProgramsUseCase;
  ProgramState? _cachedState;
  Program? _selectedProgram;

  ProgramBloc({required GetProgramsUseCase getProgramsUseCase})
      : _getProgramsUseCase = getProgramsUseCase,
        super(ProgramInitial()) {
    on<LoadPrograms>(_onLoadPrograms);
    on<RefreshPrograms>(_onRefreshPrograms);
    on<SelectProgram>(_onSelectProgram);
    on<ClearSelectedProgram>(_onClearSelectedProgram);
  }

  Future<void> _onLoadPrograms(
    LoadPrograms event,
    Emitter<ProgramState> emit,
  ) async {
    // Return cached state if available
    if (_cachedState != null) {
      emit(_cachedState!);
      return;
    }

    emit(ProgramLoading());
    try {
      await _getProgramsUseCase(NoParams()).then((result) {
        return result.fold(
          (failure) {
            final errorState = ProgramError('Error: ${failure.message}', selectedProgram: _selectedProgram);
            _cachedState = errorState;
            emit(errorState);
          },
          (programs) {
            if (programs.isEmpty) {
              const emptyState = ProgramEmpty('No programs available.');
              _cachedState = emptyState;
              emit(emptyState);
              return;
            }
            final loadedState = ProgramLoaded(programs, selectedProgram: _selectedProgram);
            _cachedState = loadedState;
            emit(loadedState);
          },
        );
      });
    } catch (e) {
      final errorState = ProgramError('Failed to load programs: $e', selectedProgram: _selectedProgram);
      _cachedState = errorState;
      emit(errorState);
    }
  }

  Future<void> _onRefreshPrograms(
    RefreshPrograms event,
    Emitter<ProgramState> emit,
  ) async {
    // Clear cache and fetch fresh data
    _cachedState = null;
    emit(ProgramLoading());
    try {
      await _getProgramsUseCase(NoParams()).then((result) {
        return result.fold(
          (failure) {
            final errorState = ProgramError('Error: ${failure.message}', selectedProgram: _selectedProgram);
            _cachedState = errorState;
            emit(errorState);
          },
          (programs) {
            final loadedState = ProgramLoaded(programs, selectedProgram: _selectedProgram);
            _cachedState = loadedState;
            emit(loadedState);
          },
        );
      });
    } catch (e) {
      final errorState = ProgramError('Failed to refresh programs: $e', selectedProgram: _selectedProgram);
      _cachedState = errorState;
      emit(errorState);
    }
  }
  void _onSelectProgram(
    SelectProgram event,
    Emitter<ProgramState> emit,
  ) {
    _selectedProgram = event.program;
    
    // Update current state with selected program
    if (state is ProgramLoaded) {
      final currentState = state as ProgramLoaded;
      final newState = ProgramLoaded(currentState.programs, selectedProgram: _selectedProgram);
      _cachedState = newState;
      emit(newState);
    } else if (state is ProgramError) {
      final currentState = state as ProgramError;
      final newState = ProgramError(currentState.message, selectedProgram: _selectedProgram);
      _cachedState = newState;
      emit(newState);
    } else if (state is ProgramEmpty) {
      final currentState = state as ProgramEmpty;
      final newState = ProgramEmpty(currentState.message, selectedProgram: _selectedProgram);
      _cachedState = newState;
      emit(newState);
    }
  }

  void _onClearSelectedProgram(
    ClearSelectedProgram event,
    Emitter<ProgramState> emit,
  ) {
    _selectedProgram = null;
    
    // Update current state without selected program
    if (state is ProgramLoaded) {
      final currentState = state as ProgramLoaded;
      final newState = ProgramLoaded(currentState.programs);
      _cachedState = newState;
      emit(newState);
    } else if (state is ProgramError) {
      final currentState = state as ProgramError;
      final newState = ProgramError(currentState.message);
      _cachedState = newState;
      emit(newState);
    } else if (state is ProgramEmpty) {
      final currentState = state as ProgramEmpty;
      final newState = ProgramEmpty(currentState.message);
      _cachedState = newState;
      emit(newState);
    }
  }

  void clearCache() {
    _cachedState = null;
  }

  Program? get selectedProgram => _selectedProgram;
}
