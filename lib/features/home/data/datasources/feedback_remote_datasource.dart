import 'package:esl/core/error/exceptions.dart';
import 'package:esl/core/networks/dio_client.dart';
import 'package:esl/features/home/data/datasources/home_endpoints.dart';
import 'package:esl/features/home/data/models/feedback_model.dart';
import 'package:esl/features/home/domain/entities/feedback.dart';

abstract class FeedbackRemoteDataSource {
  Future<FeedbackModel> submitFeedback(Feedback feedback);
}

class FeedbackRemoteDataSourceImpl extends FeedbackRemoteDataSource {
  final DioClient dioClient;
  FeedbackRemoteDataSourceImpl(this.dioClient);

  @override
  Future<FeedbackModel> submitFeedback(Feedback feedback) async {
    try {
      final response = await dioClient.post<FeedbackModel>(
        HomeEndpoints.submitFeedback,
        data: FeedbackModel.fromEntity(feedback).toJson(),
        fromJsonT: (json) =>
            FeedbackModel.fromJson(json as Map<String, dynamic>),
      );
      if (!response.success) {
        throw ServerException(response.message, response.error);
      }
      return response.data!;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
