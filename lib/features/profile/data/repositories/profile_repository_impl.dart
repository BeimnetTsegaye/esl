import 'package:esl/core/error/exceptions.dart';
import 'package:esl/core/error/failure.dart';
import 'package:esl/core/networks/network_info.dart';
import 'package:esl/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:esl/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/src/either.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(
          await remoteDataSource.changePassword(currentPassword, newPassword),
        );
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Future.value(
        const Left(NetworkFailure(message: 'No internet connection')),
      );
    }
  }
}
