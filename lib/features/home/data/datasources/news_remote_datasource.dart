import 'package:esl/core/networks/dio_client.dart';
import 'package:esl/features/home/data/datasources/home_endpoints.dart';
import 'package:esl/features/home/data/models/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getNews();
  Future<List<NewsModel>> getArticlesBySource(String sourceId);

  Future<List<NewsModel>> getArticlesByCategory(String category);

  Future<List<NewsModel>> getArticlesBySearch(String query);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final DioClient dioClient;
  NewsRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<NewsModel>> getNews() async {
    try {
      final response = await dioClient.get<List<NewsModel>>(
        HomeEndpoints.getNews,
        fromJsonT: (json) {
          if (json is! List) {
            throw Exception('Expected a list of news articles');
          }
          return json
              .map(
                (newsJson) =>
                    NewsModel.fromJson(newsJson as Map<String, dynamic>),
              )
              .toList();
        },
      );
      if (!response.success) {
        throw Exception(response.message);
      }
      return response.data!;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<NewsModel>> getArticlesByCategory(String category) {
    // TODO: implement getArticlesByCategory
    throw UnimplementedError();
  }

  @override
  Future<List<NewsModel>> getArticlesBySearch(String query) {
    // TODO: implement getArticlesBySearch
    throw UnimplementedError();
  }

  @override
  Future<List<NewsModel>> getArticlesBySource(String sourceId) {
    // TODO: implement getArticlesBySource
    throw UnimplementedError();
  }
}
