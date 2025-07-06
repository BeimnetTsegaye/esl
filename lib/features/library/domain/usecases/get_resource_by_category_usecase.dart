import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/library/domain/entities/research.dart';
import 'package:esl/features/library/domain/repositories/resource_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetResourceByCategoryUseCase extends UseCase<List<Research>, NoParams> {
  final ResourceRepository resourceRepository;

  GetResourceByCategoryUseCase(this.resourceRepository);

  @override
  Future<Either<Failure, List<Research>>> call(NoParams params) async {
    return await resourceRepository.getResourceByCategory();
  }
}
