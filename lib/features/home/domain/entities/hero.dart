import 'package:esl/features/home/domain/entities/event.dart';
import 'package:esl/features/home/domain/entities/news.dart';

class HeroEntity {
  final List<News> news;
  final List<Event> events;

  HeroEntity({required this.news, required this.events});

}
