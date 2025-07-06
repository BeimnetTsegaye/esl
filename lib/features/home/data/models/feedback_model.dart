import 'package:esl/features/home/domain/entities/feedback.dart';

class FeedbackModel extends Feedback {
  const FeedbackModel({
    required this.id,
    required super.userId,
    required super.group,
    required super.rating,
    required super.comment,
  });

  final String id;

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      group: FeedbackGroup.fromString(json['group'] as String),
      rating: json['rating'] as int,
      comment: json['comment'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'group': group.value,
      'rating': rating,
      'comment': comment,
    };
  }

  factory FeedbackModel.fromEntity(Feedback feedback) {
    return FeedbackModel(
      id: '',
      userId: feedback.userId,
      group: feedback.group,
      rating: feedback.rating,
      comment: feedback.comment,
    );
  }

  Feedback toEntity() {
    return Feedback(
      userId: userId,
      group: group,
      rating: rating,
      comment: comment,
    );
  }

  @override
  List<Object?> get props => [userId, group, rating, comment];
}
