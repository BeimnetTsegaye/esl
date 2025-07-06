import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/home/domain/entities/feedback.dart';
import 'package:esl/features/home/domain/repositories/feedback_repository.dart';
import 'package:fpdart/fpdart.dart';

class SubmitFeedbackUsecase extends UseCase<Feedback, Feedback> {
  final FeedbackRepository feedbackRepository;

  SubmitFeedbackUsecase(this.feedbackRepository);

  @override
  Future<Either<Failure, Feedback>> call(Feedback feedback) async {
    return await feedbackRepository.submitFeedback(feedback);
  }
}
