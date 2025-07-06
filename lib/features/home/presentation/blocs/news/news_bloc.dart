import 'package:equatable/equatable.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/home/domain/entities/news.dart';
import 'package:esl/features/home/domain/usecases/get_news_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase _getNewsUseCase;
  NewsState? _cachedState;

  NewsBloc({required GetNewsUseCase getNewsUseCase})
      : _getNewsUseCase = getNewsUseCase,
        super(NewsInitial()) {
    on<GetNews>(_onGetNews);
    on<RefreshNews>(_onRefreshNews);
  }

  Future<void> _onGetNews(GetNews event, Emitter<NewsState> emit) async {
    // Return cached state if available
    if (_cachedState != null) {
      emit(_cachedState!);
      return;
    }

    emit(NewsLoading());
    await _getNewsUseCase.call(NoParams()).then((result) {
      return result.fold(
        (onLeft) {
          const errorState = NewsError('Failed to fetch news');
          _cachedState = errorState;
          emit(errorState);
        },
        (news) {
          if (news.isEmpty) {
            const emptyState = NewsEmpty();
            _cachedState = emptyState;
            emit(emptyState);
          } else {
            final loadedState = NewsLoaded(news);
            _cachedState = loadedState;
            emit(loadedState);
          }
        },
      );
    });
  }

  Future<void> _onRefreshNews(RefreshNews event, Emitter<NewsState> emit) async {
    // Clear cache and fetch fresh data
    _cachedState = null;
    emit(NewsLoading());
    await _getNewsUseCase.call(NoParams()).then((result) {
      return result.fold(
        (onLeft) {
          const errorState = NewsError('Failed to fetch news');
          _cachedState = errorState;
          emit(errorState);
        },
        (news) {
          if (news.isEmpty) {
            const emptyState = NewsEmpty();
            _cachedState = emptyState;
            emit(emptyState);
          } else {
            final loadedState = NewsLoaded(news);
            _cachedState = loadedState;
            emit(loadedState);
          }
        },
      );
    });
  }

  void clearCache() {
    _cachedState = null;
  }
}
