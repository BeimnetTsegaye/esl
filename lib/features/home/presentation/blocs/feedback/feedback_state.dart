part of 'feedback_bloc.dart';

class FeedbackState {
  const FeedbackState();
}

class InitialFeedbackState extends FeedbackState {}

class LoadingFeedbackState extends FeedbackState {}

class LoadedFeedbackState extends FeedbackState {
  final Feedback feedback;
  const LoadedFeedbackState(this.feedback);
}

class FeedbackSubmittedState extends FeedbackState {}

class ErrorFeedbackState extends FeedbackState {
  final String error;
  const ErrorFeedbackState(this.error);
}
