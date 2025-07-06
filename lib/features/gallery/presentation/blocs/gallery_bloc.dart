import 'package:equatable/equatable.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/gallery/domain/entities/gallery.dart';
import 'package:esl/features/gallery/domain/usecases/get_gallery_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GetGalleryUseCase _getGalleryUseCase;
  GalleryState? _cachedState;

  GalleryBloc({required GetGalleryUseCase getGalleryUseCase})
      : _getGalleryUseCase = getGalleryUseCase,
        super(GalleryInitial()) {
    on<GetGallery>(_onGetGallery);
    on<RefreshGallery>(_onRefreshGallery);
  }

  Future<void> _onGetGallery(
    GetGallery event,
    Emitter<GalleryState> emit,
  ) async {
    // Return cached state if available
    if (_cachedState != null) {
      emit(_cachedState!);
      return;
    }

    emit(GalleryLoading());
    await _getGalleryUseCase.call(NoParams()).then((result) {
      result.fold(
        (failure) {
          final errorState = GalleryError(
            failure.message ?? 'An error occurred(at GalleryBloc)',
          );
          _cachedState = errorState;
          emit(errorState);
        },
        (galleries) {
          if (galleries.isEmpty) {
            const emptyState = GalleryEmpty('No galleries found');
            _cachedState = emptyState;
            emit(emptyState);
          } else {
            final loadedState = GalleryLoaded(galleries);
            _cachedState = loadedState;
            emit(loadedState);
          }
        },
      );
    });
  }

  Future<void> _onRefreshGallery(
    RefreshGallery event,
    Emitter<GalleryState> emit,
  ) async {
    // Clear cache and fetch fresh data
    _cachedState = null;
    emit(GalleryLoading());
    await _getGalleryUseCase.call(NoParams()).then((result) {
      result.fold(
        (failure) {
          final errorState = GalleryError(
            failure.message ?? 'An error occurred(at GalleryBloc)',
          );
          _cachedState = errorState;
          emit(errorState);
        },
        (galleries) {
          if (galleries.isEmpty) {
            const emptyState = GalleryEmpty('No galleries found');
            _cachedState = emptyState;
            emit(emptyState);
          } else {
            final loadedState = GalleryLoaded(galleries);
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
