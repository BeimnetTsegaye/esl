import 'package:esl/core/error/failure.dart';
import 'package:esl/core/networks/network_info.dart';
import 'package:esl/features/my_course/data/datasources/my_course_remote_datasource.dart';
import 'package:esl/features/my_course/data/models/enrolled_program_model.dart';
import 'package:esl/features/my_course/domain/entities/grade.dart';
import 'package:esl/features/my_course/domain/entities/weekly_schedule.dart';
import 'package:esl/features/my_course/domain/repositories/my_course_repository.dart';
import 'package:fpdart/fpdart.dart';

class MyCourseRepositoryImpl implements MyCourseRepository {
  final MyCourseRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MyCourseRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Grade>> getGrade({String? semester}) async {
    if (await networkInfo.isConnected) {
      try {
        final grade = await remoteDataSource.getGrade(semester: semester);
        return Right(grade.toEntity());
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, WeeklySchedule>> getWeeklySchedule() async {
    if (await networkInfo.isConnected) {
      try {
        final weeklySchedule = await remoteDataSource.getWeeklySchedule();
        return Right(weeklySchedule);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(ServerFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<EnrolledProgramModel>>> getEnrolledProgram() async {
    if (await networkInfo.isConnected) {
      try {
        final enrolledPrograms = await remoteDataSource.getEnrolledProgram();
        return Right(enrolledPrograms);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(ServerFailure(message: 'No internet connection'));
    }
  }
}
