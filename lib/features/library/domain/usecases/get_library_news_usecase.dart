import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/library/domain/entities/library_news.dart';
import 'package:esl/features/library/domain/repositories/resource_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetLibraryNewsUseCase extends UseCase<LibraryNews, NoParams> {
  final ResourceRepository resourceRepository;

  GetLibraryNewsUseCase(this.resourceRepository);

  @override
  Future<Either<Failure, LibraryNews>> call(NoParams params) async {
    return await resourceRepository.getNews();
  }
}
