import 'package:esl/core/error/exceptions.dart';
import 'package:esl/core/error/failure.dart';
import 'package:esl/core/networks/network_info.dart';
import 'package:esl/features/home/data/datasources/feedback_remote_datasource.dart';
import 'package:esl/features/home/domain/entities/feedback.dart';
import 'package:esl/features/home/domain/repositories/feedback_repository.dart';
import 'package:fpdart/fpdart.dart';

class FeedbackRepositoryImpl extends FeedbackRepository {
  final FeedbackRemoteDataSource feedbackRemoteDataSource;
  final NetworkInfo networkInfo;

  FeedbackRepositoryImpl({
    required this.feedbackRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Feedback>> submitFeedback(Feedback feedback) async {
    if (await networkInfo.isConnected) {
      try {
        final feedbackModel = await feedbackRemoteDataSource.submitFeedback(
          feedback,
        );
        return Right(feedbackModel.toEntity());
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.message, errorDetails: e.errorDetails),
        );
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }
}
