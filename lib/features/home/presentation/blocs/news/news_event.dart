part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class GetNews extends NewsEvent {
  const GetNews();

  @override
  List<Object> get props => [];
}

class RefreshNews extends NewsEvent {
  const RefreshNews();

  @override
  List<Object> get props => [];
}
