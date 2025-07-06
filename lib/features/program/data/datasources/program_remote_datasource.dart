import 'package:esl/core/networks/dio_client.dart';
import 'package:esl/features/program/data/datasources/program_endpoints.dart';
import 'package:esl/features/program/data/models/program_model.dart';

abstract class ProgramRemoteDataSource {
  Future<List<ProgramModel>> getPrograms();
}

class ProgramRemoteDataSourceImpl implements ProgramRemoteDataSource {
  final DioClient dioClient;

  ProgramRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<ProgramModel>> getPrograms() async {
    try {
      final response = await dioClient.get(
        ProgramEndpoints.getPrograms,
        fromJsonT: (json) {
          if (json is! List) {
            throw Exception('Expected a list of news articles');
          }
          return json
              .map(
                (newsJson) =>
                    ProgramModel.fromJson(newsJson as Map<String, dynamic>),
              )
              .toList();
        },
      );
      if (!response.success) {
        throw Exception(response.message);
      }
      return response.data!;
    } catch (e) {
      return [];
    }
  }
}
