import 'package:equatable/equatable.dart';

class EventCategory extends Equatable {
  final String? id;
  final String? category;
  final String? description;

  const EventCategory({this.id, this.category, this.description});

  factory EventCategory.fromJson(Map<String, dynamic> json) {
    return EventCategory(
      id: json['id'] as String?,
      category: json['category'] as String?,
      description: json['description'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, category, description];
}

class Event extends Equatable {
  final String? id;
  final String? title;
  final String? excerpt;
  final String? featuredImage;
  final String? content;
  final bool? isPromotedToHero;
  final EventCategory? category;
  final DateTime? startDate;
  final DateTime? endDate;

  const Event({
    this.id,
    this.title,
    this.excerpt,
    this.featuredImage,
    this.content,
    this.isPromotedToHero,
    this.category,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    excerpt,
    featuredImage,
    content,
    isPromotedToHero,
    category,
    startDate,
    endDate,
  ];
}
