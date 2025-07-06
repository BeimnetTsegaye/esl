import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/my_course/data/models/enrolled_program_model.dart';
import 'package:esl/features/my_course/domain/entities/grade.dart';
import 'package:esl/features/my_course/domain/entities/weekly_schedule.dart';
import 'package:esl/features/my_course/domain/usecases/get_enrolled_program_usecase.dart';
import 'package:esl/features/my_course/domain/usecases/get_grade_usecase.dart';
import 'package:esl/features/my_course/domain/usecases/get_weekly_schedule_usecase.dart';
import 'package:esl/features/program/domain/entities/program.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_course_event.dart';
part 'my_course_state.dart';

class MyCourseBloc extends Bloc<MyCourseEvent, MyCourseState> {
  final GetGradeUseCase _getGradeUseCase;
  final GetWeeklyScheduleUseCase _getWeeklyScheduleUsecase;
  final GetEnrolledProgramUseCase _getEnrolledProgramUseCase;

  // Cache for different states
  MyCourseState? _cachedGradeState;
  MyCourseState? _cachedWeeklyScheduleState;
  MyCourseState? _cachedEnrolledProgramState;

  MyCourseBloc({
    required GetGradeUseCase getGradeUseCase,
    required GetWeeklyScheduleUseCase getWeeklyScheduleUsecase,
    required GetEnrolledProgramUseCase getEnrolledProgramUseCase,
  }) : _getGradeUseCase = getGradeUseCase,
       _getWeeklyScheduleUsecase = getWeeklyScheduleUsecase,
       _getEnrolledProgramUseCase = getEnrolledProgramUseCase,
       super(MyCourseInitial()) {
    on<GetGradeEvent>(_onGetGradeEvent);
    on<GetWeeklyScheduleEvent>(_onGetWeeklyScheduleEvent);
    on<GetEnrolledProgramEvent>(_onGetEnrolledProgramEvent);
    on<RefreshEnrolledProgramEvent>(_onRefreshEnrolledProgramEvent);
  }

  Future<void> _onGetGradeEvent(
    GetGradeEvent event,
    Emitter<MyCourseState> emit,
  ) async {
    // Return cached state if available
    if (_cachedGradeState != null) {
      emit(_cachedGradeState!);
      return;
    }

    emit(MyCourseLoading());
    try {
      await _getGradeUseCase.call(GradeParams(semester: event.semester)).then((
        result,
      ) {
        result.fold(
          (failure) {
            final errorState = MyCourseError(
              message: failure.message ?? 'An error occurred(at MyCourseBloc)',
            );
            _cachedGradeState = errorState;
            emit(errorState);
          },
          (grade) {
            final loadedState = MyCourseLoaded(grade: grade);
            _cachedGradeState = loadedState;
            emit(loadedState);
          },
        );
      });
    } catch (e) {
      final errorState = MyCourseError(message: e.toString());
      _cachedGradeState = errorState;
      emit(errorState);
    }
  }

  Future<void> _onGetWeeklyScheduleEvent(
    GetWeeklyScheduleEvent event,
    Emitter<MyCourseState> emit,
  ) async {
    // Return cached state if available
    if (_cachedWeeklyScheduleState != null) {
      emit(_cachedWeeklyScheduleState!);
      return;
    }

    emit(const WeeklyScheduleLoading());
    try {
      await _getWeeklyScheduleUsecase.call(NoParams()).then((result) {
        result.fold(
          (failure) {
            final errorState = WeeklyScheduleError(
              message: failure.message ?? 'An error occurred(at MyCourseBloc)',
            );
            _cachedWeeklyScheduleState = errorState;
            emit(errorState);
          },
          (weeklySchedule) {
            final loadedState = WeeklyScheduleLoaded(weeklySchedule: weeklySchedule);
            _cachedWeeklyScheduleState = loadedState;
            emit(loadedState);
          },
        );
      });
    } catch (e) {
      final errorState = WeeklyScheduleError(message: e.toString());
      _cachedWeeklyScheduleState = errorState;
      emit(errorState);
    }
  }

  Future<void> _onGetEnrolledProgramEvent(
    GetEnrolledProgramEvent event,
    Emitter<MyCourseState> emit,
  ) async {
    print('[MyCourseBloc] _onGetEnrolledProgramEvent called');
    
    // Return cached state if available
    if (_cachedEnrolledProgramState != null) {
      print('[MyCourseBloc] Returning cached state: ${_cachedEnrolledProgramState.runtimeType}');
      emit(_cachedEnrolledProgramState!);
      return;
    }

    print('[MyCourseBloc] No cache found, emitting EnrolledProgramLoading');
    emit(EnrolledProgramLoading());
    
    try {
      print('[MyCourseBloc] Calling use case...');
      
      // Add timeout to prevent infinite loading
      final result = await _getEnrolledProgramUseCase.call(NoParams())
          .timeout(const Duration(seconds: 30));
      
      print('[MyCourseBloc] Use case result received');
      result.fold(
        (failure) {
          print('[MyCourseBloc] Failure: ${failure.message}');
          final errorState = EnrolledProgramError(
            message: failure.message ?? 'An error occurred(at MyCourseBloc)',
          );
          _cachedEnrolledProgramState = errorState;
          emit(errorState);
        },
        (myPrograms) {
          print('[MyCourseBloc] Success: ${myPrograms.length} programs loaded');
          final loadedState = EnrolledProgramLoaded(myPrograms: myPrograms);
          _cachedEnrolledProgramState = loadedState;
          emit(loadedState);
        },
      );
    } on TimeoutException {
      print('[MyCourseBloc] Timeout occurred');
      const errorState = EnrolledProgramError(message: 'Request timed out. Please try again.');
      _cachedEnrolledProgramState = errorState;
      emit(errorState);
    } catch (e) {
      print('[MyCourseBloc] Exception: $e');
      final errorState = EnrolledProgramError(message: e.toString());
      _cachedEnrolledProgramState = errorState;
      emit(errorState);
    }
  }

  Future<void> _onRefreshEnrolledProgramEvent(
    RefreshEnrolledProgramEvent event,
    Emitter<MyCourseState> emit,
  ) async {
    print('[MyCourseBloc] _onRefreshEnrolledProgramEvent called');
    
    // Clear the cache to force a fresh fetch
    _cachedEnrolledProgramState = null;
    
    emit(EnrolledProgramLoading());
    try {
      print('[MyCourseBloc] Calling use case for refresh...');
      
      // Add timeout to prevent infinite loading
      final result = await _getEnrolledProgramUseCase.call(NoParams())
          .timeout(const Duration(seconds: 30));
      
      print('[MyCourseBloc] Refresh use case result received');
      result.fold(
        (failure) {
          print('[MyCourseBloc] Refresh failure: ${failure.message}');
          final errorState = EnrolledProgramError(
            message: failure.message ?? 'An error occurred(at MyCourseBloc)',
          );
          _cachedEnrolledProgramState = errorState;
          emit(errorState);
        },
        (myPrograms) {
          print('[MyCourseBloc] Refresh success: ${myPrograms.length} programs loaded');
          final loadedState = EnrolledProgramLoaded(myPrograms: myPrograms);
          _cachedEnrolledProgramState = loadedState;
          emit(loadedState);
        },
      );
    } on TimeoutException {
      print('[MyCourseBloc] Refresh timeout occurred');
      const errorState = EnrolledProgramError(message: 'Request timed out. Please try again.');
      _cachedEnrolledProgramState = errorState;
      emit(errorState);
    } catch (e) {
      print('[MyCourseBloc] Refresh exception: $e');
      final errorState = EnrolledProgramError(message: e.toString());
      _cachedEnrolledProgramState = errorState;
      emit(errorState);
    }
  }

  void clearCache() {
    _cachedGradeState = null;
    _cachedWeeklyScheduleState = null;
    _cachedEnrolledProgramState = null;
  }

  void clearGradeCache() {
    _cachedGradeState = null;
  }

  void clearWeeklyScheduleCache() {
    _cachedWeeklyScheduleState = null;
  }

  void clearEnrolledProgramCache() {
    _cachedEnrolledProgramState = null;
  }
}
