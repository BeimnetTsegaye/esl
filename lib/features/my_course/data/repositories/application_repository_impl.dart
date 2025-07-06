import 'package:esl/core/error/exceptions.dart';
import 'package:esl/core/error/failure.dart';
import 'package:esl/core/networks/network_info.dart';
import 'package:esl/features/my_course/data/datasources/application_remote_datasource.dart';
import 'package:esl/features/my_course/data/models/application_model.dart';
import 'package:esl/features/my_course/domain/entities/application.dart';
import 'package:esl/features/my_course/domain/repositories/application_repository.dart';
import 'package:fpdart/fpdart.dart';

class ApplicationRepositoryImpl implements ApplicationRepository {
  final ApplicationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ApplicationRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Application>> apply({
    required Application application,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final applicationModel = ApplicationModel.fromEntity(application);
        final applicationData = await remoteDataSource.apply(
          application: applicationModel,
        );
        return Right(applicationData.toEntity());
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.message, errorDetails: e.errorDetails),
        );
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Application>>> getApplications() {
    // TODO: implement getApplications
    throw UnimplementedError();
  }
}
