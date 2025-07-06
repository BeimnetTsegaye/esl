import 'package:esl/core/error/failure.dart';
import 'package:esl/features/home/domain/entities/feedback.dart';
import 'package:fpdart/fpdart.dart';

abstract class FeedbackRepository {
  Future<Either<Failure, Feedback>> submitFeedback(Feedback feedback);
}
