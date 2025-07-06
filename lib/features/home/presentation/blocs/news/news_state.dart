part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {
  final News fakeNews = const News(
    id: '1',
    title: 'Library Renovation Completed',
    excerpt: '',
        content: {'fake':'Fake Hero Content'},
    tags: [],
    viewsCount: 0,
    isPublished: false,
    isPromotedToHero: false,
    newsCategoryId: '',
    authorId: '',
    featuredImage: '',
  );
}

class NewsLoaded extends NewsState {
  final List<News> newsList;

  const NewsLoaded(this.newsList);

  @override
  List<Object> get props => [newsList];
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object> get props => [message];
}

class NewsEmpty extends NewsState {
  const NewsEmpty();

  @override
  List<Object> get props => [];
}
