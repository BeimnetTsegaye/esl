part of 'hero_bloc.dart';

abstract class HeroEvent extends Equatable {
  const HeroEvent();

  @override
  List<Object> get props => [];
}

class GetHeroes extends HeroEvent {}

class RefreshHeroes extends HeroEvent {}
