import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/library/domain/entities/author.dart';
import 'package:esl/features/library/domain/repositories/resource_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetResourceByAuthorsUseCase extends UseCase<List<Author>, NoParams> {
  final ResourceRepository resourceRepository;

  GetResourceByAuthorsUseCase(this.resourceRepository);

  @override
  Future<Either<Failure, List<Author>>> call(NoParams params) async {
    return await resourceRepository.getResourceByAuthors();
  }
}
