import 'package:esl/core/error/failure.dart';
import 'package:esl/features/home/domain/entities/news.dart';
import 'package:fpdart/fpdart.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<News>>> getNews();

  Future<Either<Failure, List<News>>> getArticlesBySource(String sourceId);

  Future<Either<Failure, List<News>>> getArticlesByCategory(String category);

  Future<Either<Failure, List<News>>> getArticlesBySearch(String query);
}
