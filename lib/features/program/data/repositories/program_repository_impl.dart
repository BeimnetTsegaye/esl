import 'package:esl/core/error/failure.dart';
import 'package:esl/core/networks/network_info.dart';
import 'package:esl/features/program/data/datasources/program_remote_datasource.dart';
import 'package:esl/features/program/domain/entities/program.dart';
import 'package:esl/features/program/domain/repositories/program_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProgramRepositoryImpl implements ProgramRepository {
  final ProgramRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  ProgramRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Program>>> getPrograms() async {
    if (await networkInfo.isConnected) {
      try {
        final programs = await remoteDataSource.getPrograms();
        return Right(programs.map((e) => e.toEntity()).toList());
      } catch (error) {
        return Left(ServerFailure(message: error.toString()));
      }
    } else {
      return Future.value(
        const Left(NetworkFailure(message: 'No internet connection')),
      );
    }
  }
}
