import 'package:esl/features/home/data/models/news_model.dart';
import 'package:esl/features/home/domain/entities/news.dart';

class LibraryNews {
  final List<News> popularNews;
  final List<News> latestNews;

  LibraryNews({required this.popularNews, required this.latestNews});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LibraryNews &&
          runtimeType == other.runtimeType &&
          popularNews == other.popularNews &&
          latestNews == other.latestNews;

  @override
  int get hashCode => popularNews.hashCode ^ latestNews.hashCode;

  factory LibraryNews.fromJson(Map<String, dynamic> json) {
    // Handle the new API response structure where 'data' contains 'latest' and 'popular'
    if (json.containsKey('data')) {
      final data = json['data'];
      return LibraryNews(
        popularNews: (data['popular'] as List?)
            ?.map((item) => NewsModel.fromJson(item as Map<String, dynamic>).toEntity())
            .toList() ?? [],
        latestNews: (data['latest'] as List?)
            ?.map((item) => NewsModel.fromJson(item as Map<String, dynamic>).toEntity())
            .toList() ?? [],
      );
    }

    // Handle the case where news is a direct array (legacy fallback)
    if (json.containsKey('news') && json['news'] is List) {
      final newsList = (json['news'] as List).map(
        (item) => NewsModel.fromJson(item as Map<String, dynamic>).toEntity(),
      ).toList();
      // Split the news into popular and latest (for now, just use the same list)
      return LibraryNews(
        popularNews: newsList.take((newsList.length / 2).ceil()).toList(),
        latestNews: newsList.skip((newsList.length / 2).ceil()).toList(),
      );
    }
    
    // Handle the old structure with popular and latest fields
    return LibraryNews(
      popularNews: (json['popular'] as List?)
          ?.map(
            (item) =>
                NewsModel.fromJson(item as Map<String, dynamic>).toEntity(),
          )
          .toList() ?? [],
      latestNews: (json['latest'] as List?)
          ?.map(
            (item) =>
                NewsModel.fromJson(item as Map<String, dynamic>).toEntity(),
          )
          .toList() ?? [],
    );
  }
}
