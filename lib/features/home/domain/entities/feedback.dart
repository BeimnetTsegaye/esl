import 'package:equatable/equatable.dart';

enum FeedbackGroup {
  customer('Customer'),
  partner('Partner'),
  employee('Employee'),
  other('Other');

  const FeedbackGroup(this.value);

  final String value;

  factory FeedbackGroup.fromString(String value) {
    return FeedbackGroup.values.firstWhere(
      (e) => e.value.toLowerCase() == value.toLowerCase(),
      orElse: () => FeedbackGroup.other, // Provide a default or throw an error
    );
  }
}

class Feedback extends Equatable {
  final String userId;
  final FeedbackGroup group;
  final int rating;
  final String comment;

  const Feedback({
    required this.userId,
    required this.group,
    required this.rating,
    required this.comment,
  });

  @override
  List<Object?> get props => [userId, group, rating, comment];
}
