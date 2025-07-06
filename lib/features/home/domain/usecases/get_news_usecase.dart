import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/home/domain/entities/news.dart';
import 'package:esl/features/home/domain/repositories/news_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetNewsUseCase extends UseCase<List<News>, NoParams> {
  final NewsRepository newsRepository;

  GetNewsUseCase(this.newsRepository);

  @override
  Future<Either<Failure, List<News>>> call(NoParams params) async {
    return await newsRepository.getNews();
  }
}
