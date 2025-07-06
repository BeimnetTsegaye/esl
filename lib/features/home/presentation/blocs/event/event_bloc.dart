import 'package:esl/features/home/domain/entities/event.dart';
import 'package:esl/features/home/domain/usecases/get_events_by_date_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final GetEventsByDateUseCase _getEventsByDateUseCase;
  final Map<DateTime, EventState> _cachedStates = {};

  EventBloc({required GetEventsByDateUseCase getEventsByDateUseCase})
    : _getEventsByDateUseCase = getEventsByDateUseCase,
      super(InitialEventState()) {
    on<GetEventsByDateEvent>(_onGetEventsByDate);
    on<RefreshEvents>(_onRefreshEvents);
  }

  Future<void> _onGetEventsByDate(
    GetEventsByDateEvent event,
    Emitter<EventState> emit,
  ) async {
    // Check if we have a cached state for this date
    final normalizedDate = DateTime(
      event.date.year,
      event.date.month,
      event.date.day,
    );
    
    if (_cachedStates.containsKey(normalizedDate)) {
      emit(_cachedStates[normalizedDate]!);
      return;
    }

    emit(LoadingEventState());
    final result = await _getEventsByDateUseCase.call(
      GetEventsByDateParams(date: event.date),
    );
    
    result.fold(
      (failure) {
        final errorState = ErrorEventState(
          failure.message ?? 'An unknown error occurred(at event bloc)',
        );
        _cachedStates[normalizedDate] = errorState;
        emit(errorState);
      },
      (events) {
        final loadedState = LoadedEventState(events);
        _cachedStates[normalizedDate] = loadedState;
        emit(loadedState);
      },
    );
  }

  Future<void> _onRefreshEvents(
    RefreshEvents event,
    Emitter<EventState> emit,
  ) async {
    // Clear cache for this specific date and fetch fresh data
    final normalizedDate = DateTime(
      event.date.year,
      event.date.month,
      event.date.day,
    );
    
    _cachedStates.remove(normalizedDate);
    emit(LoadingEventState());
    final result = await _getEventsByDateUseCase.call(
      GetEventsByDateParams(date: event.date),
    );
    
    result.fold(
      (failure) {
        final errorState = ErrorEventState(
          failure.message ?? 'An unknown error occurred(at event bloc)',
        );
        _cachedStates[normalizedDate] = errorState;
        emit(errorState);
      },
      (events) {
        final loadedState = LoadedEventState(events);
        _cachedStates[normalizedDate] = loadedState;
        emit(loadedState);
      },
    );
  }

  void clearCache() {
    _cachedStates.clear();
  }

  void clearCacheForDate(DateTime date) {
    final normalizedDate = DateTime(
      date.year,
      date.month,
      date.day,
    );
    _cachedStates.remove(normalizedDate);
  }
}
