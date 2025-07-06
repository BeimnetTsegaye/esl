part of 'hero_bloc.dart';

abstract class HeroState extends Equatable {
  const HeroState();

  @override
  List<Object> get props => [];
}

class HeroInitial extends HeroState {}

class HeroLoading extends HeroState {
  final HeroEntity fakeHero = HeroEntity(
    news: List.generate(
      3,
      (index) => const News(
        id: '1',
        title: 'Fake Hero',
        excerpt: 'Fake Hero Description',
        content: {'fake':'Fake Hero Content'},
        tags: [],
        viewsCount: 0,
        isPublished: false,
        isPromotedToHero: false,
        newsCategoryId: '1',
        authorId: '1',
        featuredImage: 'https://via.placeholder.com/150',
      ),
    ),
    events: List.generate(
      3,
      (index) => Event(
        id: '1',
        title: 'Fake Event',
        excerpt: 'Fake Event Description',
        content: 'Fake Event Content',
        featuredImage: 'https://via.placeholder.com/150',
        isPromotedToHero: false,
        category: const EventCategory(
          id: '1',
          category: 'Fake Event Category',
          description: 'Fake Event Description',
        ),
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 1)),
      ),
    ),
  );
}

class HeroLoaded extends HeroState {
  final HeroEntity hero;

  const HeroLoaded({required this.hero});

  @override
  List<Object> get props => [hero];
}

class HeroError extends HeroState {
  final String message;

  const HeroError({required this.message});

  @override
  List<Object> get props => [message];
}
