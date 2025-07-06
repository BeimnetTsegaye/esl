import 'package:esl/core/error/exceptions.dart';
import 'package:esl/core/networks/dio_client.dart';
import 'package:esl/features/home/data/datasources/home_endpoints.dart';
import 'package:esl/features/home/data/models/hero_model.dart';

abstract class HeroRemoteDataSource {
  Future<HeroModel> getHeroes();
}

class HeroRemoteDataSourceImpl extends HeroRemoteDataSource {
  final DioClient dio;

  HeroRemoteDataSourceImpl({required this.dio});

  @override
  Future<HeroModel> getHeroes() async {
    try {
      final response = await dio.get<HeroModel>(
        HomeEndpoints.getHeroes,
        fromJsonT: (json) => HeroModel.fromJson(json as Map<String, dynamic>),
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
