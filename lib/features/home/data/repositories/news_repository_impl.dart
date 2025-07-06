import 'package:esl/core/error/failure.dart';
import 'package:esl/core/networks/network_info.dart';
import 'package:esl/features/home/data/datasources/news_remote_datasource.dart';
import 'package:esl/features/home/domain/entities/news.dart';
import 'package:esl/features/home/domain/repositories/news_repository.dart';
import 'package:fpdart/fpdart.dart';

class NewsRepositoryImpl extends NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<News>>> getNews() async {
    if (await networkInfo.isConnected) {
      try {
        final newsList = await remoteDataSource.getNews();
        return Right(newsList.map((news) => news.toEntity()).toList());
      } catch (error) {
        return Left(ServerFailure(message: error.toString()));
      }
    } else {
      return Future.value(
        const Left(NetworkFailure(message: 'No internet connection')),
      );
    }
  }

  @override
  Future<Either<Failure, List<News>>> getArticlesBySearch(String query) {
    // TODO: implement getArticlesBySearch
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<News>>> getArticlesBySource(String sourceId) {
    // TODO: implement getArticlesBySource
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<News>>> getArticlesByCategory(String category) {
    // TODO: implement getArticlesByCategory
    throw UnimplementedError();
  }
}
