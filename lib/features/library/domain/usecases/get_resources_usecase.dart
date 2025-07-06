import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/library/domain/entities/resource.dart';
import 'package:esl/features/library/domain/repositories/resource_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetResourcesUseCase extends UseCase<Resource, NoParams> {
  final ResourceRepository repository;

  GetResourcesUseCase(this.repository);

  @override
  Future<Either<Failure, Resource>> call(NoParams params) async {
    return await repository.getResources();
  }
}
