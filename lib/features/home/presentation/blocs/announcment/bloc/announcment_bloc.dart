import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/home/domain/entities/announcment.dart';
import 'package:esl/features/home/domain/usecases/get_announcments_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'announcment_event.dart';
part 'announcment_state.dart';

class AnnouncmentBloc extends Bloc<AnnouncmentEvent, AnnouncmentState> {
  final GetAnnouncmentsUsecase _getAnnouncmentsUsecase;
  List<Announcment> _announcments = [];
  AnnouncmentState? _currentState;

  AnnouncmentBloc({required GetAnnouncmentsUsecase getAnnouncmentsUsecase})
    : _getAnnouncmentsUsecase = getAnnouncmentsUsecase,
      super(AnnouncmentInitial()) {
    on<GetAnnouncmentsEvent>(_onGetAnnouncments);
    on<RefreshAnnouncmentsEvent>(_onRefreshAnnouncments);
    on<RemoveAnnouncmentEvent>(_onRemoveAnnouncment);
  }

  Future<void> _onGetAnnouncments(
    GetAnnouncmentsEvent event,
    Emitter<AnnouncmentState> emit,
  ) async {
    if (_currentState != null) {
      emit(_currentState!);
      return;
    }
    _currentState = AnnouncmentLoading();
    emit(_currentState!);
    final result = await _getAnnouncmentsUsecase.call(NoParams());
    result.fold(
      (failure) => emit(
        AnnouncmentError(
          message:
              failure.message ??
              'Unknown error occurred while fetching announcments',
        ),
      ),
      (announcments) {
        _announcments = announcments;
        if (announcments.isEmpty) {
          _currentState = AnnouncmentEmpty();
          emit(_currentState!);
        } else {
          _currentState = AnnouncmentLoaded(announcments);
          emit(_currentState!);
        }
      },
    );
  }

  Future<void> _onRefreshAnnouncments(
    RefreshAnnouncmentsEvent event,
    Emitter<AnnouncmentState> emit,
  ) async {
    // Clear cache and fetch fresh data
    _currentState = null;
    _announcments.clear();
    _currentState = AnnouncmentLoading();
    emit(_currentState!);
    final result = await _getAnnouncmentsUsecase.call(NoParams());
    result.fold(
      (failure) => emit(
        AnnouncmentError(
          message:
              failure.message ??
              'Unknown error occurred while fetching announcments',
        ),
      ),
      (announcments) {
        _announcments = announcments;
        if (announcments.isEmpty) {
          _currentState = AnnouncmentEmpty();
          emit(_currentState!);
        } else {
          _currentState = AnnouncmentLoaded(announcments);
          emit(_currentState!);
        }
      },
    );
  }

  void _onRemoveAnnouncment(
    RemoveAnnouncmentEvent event,
    Emitter<AnnouncmentState> emit,
  ) {
    if (event.index >= 0 && event.index < _announcments.length) {
      _announcments.removeAt(event.index);
      if (_announcments.isEmpty) {
        _currentState = AnnouncmentEmpty();
        emit(_currentState!);
      } else {
        _currentState = AnnouncmentLoaded(_announcments);
        emit(_currentState!);
      }
    }
  }
}
