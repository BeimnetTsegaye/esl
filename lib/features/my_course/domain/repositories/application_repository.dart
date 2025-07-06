import 'package:esl/core/error/failure.dart';
import 'package:esl/features/my_course/domain/entities/application.dart';
import 'package:fpdart/fpdart.dart';

abstract class ApplicationRepository {
  Future<Either<Failure, Application>> apply({
    required Application application,
  });
  Future<Either<Failure, List<Application>>> getApplications();
}
