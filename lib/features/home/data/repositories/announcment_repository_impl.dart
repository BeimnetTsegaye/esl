import 'package:esl/core/error/failure.dart';
import 'package:esl/core/networks/network_info.dart';
import 'package:esl/features/home/data/datasources/announcment_remote_datasource.dart';
import 'package:esl/features/home/domain/entities/announcment.dart';
import 'package:esl/features/home/domain/repositories/announcment_repository.dart';
import 'package:fpdart/fpdart.dart';

class AnnouncmentRepositoryImpl extends AnnouncmentRepository {
  final AnnouncmentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AnnouncmentRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Announcment>>> getAnnouncments() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAnnouncments = await remoteDataSource.getAnnouncments();
        return Right(remoteAnnouncments.map((e) => e.toEntity()).toList());
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(ServerFailure(message: 'No internet connection'));
    }
  }
}
