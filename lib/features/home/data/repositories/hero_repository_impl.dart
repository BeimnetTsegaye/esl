import 'package:esl/core/error/failure.dart';
import 'package:esl/core/networks/network_info.dart';
import 'package:esl/features/home/data/datasources/hero_remote_datasource.dart';
import 'package:esl/features/home/domain/entities/hero.dart';
import 'package:esl/features/home/domain/repositories/hero_repository.dart';
import 'package:fpdart/fpdart.dart';

class HeroRepositoryImpl extends HeroRepository {
  final HeroRemoteDataSource heroRemoteDataSource;
  final NetworkInfo networkInfo;

  HeroRepositoryImpl({
    required this.heroRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, HeroEntity>> getHeroes() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await heroRemoteDataSource.getHeroes();
        return Right(response.toEntity());
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(ServerFailure(message: 'No internet connection'));
    }
  }
}
