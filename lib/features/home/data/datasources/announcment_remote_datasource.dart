import 'package:esl/core/error/exceptions.dart';
import 'package:esl/core/networks/dio_client.dart';
import 'package:esl/features/home/data/datasources/home_endpoints.dart';
import 'package:esl/features/home/data/models/announcment_model.dart';

abstract class AnnouncmentRemoteDataSource {
  Future<List<AnnouncmentModel>> getAnnouncments();
}

class AnnouncmentRemoteDataSourceImpl extends AnnouncmentRemoteDataSource {
  final DioClient dioClient;

  AnnouncmentRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<AnnouncmentModel>> getAnnouncments() async {
    try {
      final response = await dioClient.get<List<AnnouncmentModel>>(
        HomeEndpoints.getAnnouncments,
        fromJsonT: (json) => (json as List)
            .map((e) => AnnouncmentModel.fromJson(e as Map<String, dynamic>))
            .toList(),
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
