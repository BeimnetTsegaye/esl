import 'package:esl/features/home/data/models/event_model.dart';
import 'package:esl/features/home/data/models/news_model.dart';
import 'package:esl/features/home/domain/entities/hero.dart';

class HeroModel extends HeroEntity {
  HeroModel({required super.news, required super.events});

  factory HeroModel.fromJson(Map<String, dynamic> json) {
    return HeroModel(
      news: (json['news'] as List<dynamic>)
          .map((e) => NewsModel.fromJson(e as Map<String, dynamic>).toEntity())
          .toList(),
      events: (json['events'] as List<dynamic>)
          .map((e) => EventModel.fromJson(e as Map<String, dynamic>).toEntity())
          .toList(),
    );
  }

  HeroEntity toEntity() {
    return HeroEntity(news: news, events: events);
  }
}
