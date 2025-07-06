import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/my_course/domain/entities/application.dart';
import 'package:esl/features/my_course/domain/repositories/application_repository.dart';
import 'package:fpdart/fpdart.dart';

class ApplyUseCase extends UseCase<void, Application> {
  final ApplicationRepository repository;

  ApplyUseCase(this.repository);

  @override
  Future<Either<Failure, Application>> call(Application application) {
    return repository.apply(application: application);
  }
}
