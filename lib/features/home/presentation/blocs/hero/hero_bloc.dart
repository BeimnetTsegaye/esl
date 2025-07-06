import 'package:equatable/equatable.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/home/domain/entities/event.dart';
import 'package:esl/features/home/domain/entities/hero.dart';
import 'package:esl/features/home/domain/entities/news.dart';
import 'package:esl/features/home/domain/usecases/get_heroes_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hero_event.dart';
part 'hero_state.dart';

class HeroBloc extends Bloc<HeroEvent, HeroState> {
  final GetHeroesUsecase _getHeroesUsecase;
  HeroState? _cachedState;

  HeroBloc({required GetHeroesUsecase getHeroesUsecase})
      : _getHeroesUsecase = getHeroesUsecase,
        super(HeroInitial()) {
    on<GetHeroes>(_onGetHeroes);
    on<RefreshHeroes>(_onRefreshHeroes);
  }

  Future<void> _onGetHeroes(GetHeroes event, Emitter<HeroState> emit) async {
    if (_cachedState != null) {
      emit(_cachedState!);
      return;
    }

    emit(HeroLoading());
    await _getHeroesUsecase.call(NoParams()).then((result) {
      return result.fold(
        (onLeft) {
          const errorState = HeroError(message: 'Failed to fetch heroes');
          _cachedState = errorState;
          emit(errorState);
        },
        (onRight) {
          _cachedState = HeroLoaded(hero: onRight);
          emit(HeroLoaded(hero: onRight));
        },
      );
    });
  }

  Future<void> _onRefreshHeroes(RefreshHeroes event, Emitter<HeroState> emit) async {
    // Clear cache and fetch fresh data
    _cachedState = null;
    emit(HeroLoading());
    await _getHeroesUsecase.call(NoParams()).then((result) {
      return result.fold(
        (onLeft) {
          const errorState = HeroError(message: 'Failed to fetch heroes');
          _cachedState = errorState;
          emit(errorState);
        },
        (onRight) {
          _cachedState = HeroLoaded(hero: onRight);
          emit(HeroLoaded(hero: onRight));
        },
      );
    });
  }
}
