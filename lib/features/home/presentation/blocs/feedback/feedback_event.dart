part of 'feedback_bloc.dart';

abstract class FeedbackEvent {
  const FeedbackEvent();
}

class FeedbackSubmitted extends FeedbackEvent {
  final Feedback feedback;
  const FeedbackSubmitted(this.feedback);
}
