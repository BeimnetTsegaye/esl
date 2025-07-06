import 'package:esl/features/home/domain/entities/event.dart';

class EventModel extends Event {
  const EventModel({
     super.id,
     super.title,
     super.excerpt,
     super.featuredImage,
     super.content,
    super.isPromotedToHero,
     super.category,
     super.startDate,
     super.endDate,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      excerpt: json['excerpt'] as String,
      featuredImage: json['featuredImage'] as String,
      content: json['content'] as String,
      isPromotedToHero: json['isPromotedToHero'] as bool? ?? false,
      category: EventCategory.fromJson(json['category'] as Map<String, dynamic>),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );
  }


  factory EventModel.fromEntity(Event event) {
    return EventModel(
      id: event.id,
      title: event.title,
      excerpt: event.excerpt,
      featuredImage: event.featuredImage,
      content: event.content,
      isPromotedToHero: event.isPromotedToHero,
      category: event.category,
      startDate: event.startDate,
      endDate: event.endDate,
    );
  }

  Event toEntity() {
    return Event(
      id: id,
      title: title,
      excerpt: excerpt,
      featuredImage: featuredImage,
      content: content,
      isPromotedToHero: isPromotedToHero,
      category: category,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
