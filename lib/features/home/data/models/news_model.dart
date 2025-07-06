import 'dart:convert';
import 'package:esl/features/home/domain/entities/news.dart';

class NewsModel extends News {
  const NewsModel({
     super.id,
     super.title,
     super.content,
     super.tags,
     super.viewsCount,
     super.isPublished,
     super.isPromotedToHero,
     super.newsCategoryId,
     super.authorId,
     super.featuredImage,
     super.excerpt,
     super.newsCategory,
     super.author,
     super.count,
     super.comments,
     super.likes,
     super.startDate,
     super.endDate,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? content;
    if (json['content'] != null) {
      if (json['content'] is String) {
        try {
          content = jsonDecode(json['content'] as String) as Map<String, dynamic>;
        } catch (e) {
          content = {'text': json['content'] as String};
        }
      } else if (json['content'] is Map<String, dynamic>) {
        content = json['content'] as Map<String, dynamic>;
      }
    }

    return NewsModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      content: content,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => (e as Map<String, dynamic>)['tag'] as String)
          .toList(),
      viewsCount: json['viewsCount'] as int?,
      isPublished: json['isPublished'] as bool? ?? false,
      isPromotedToHero: json['isPromotedToHero'] as bool? ?? false,
      newsCategoryId: json['newsCategoryId'] as String?,
      authorId: json['authorId'] as String?,
      featuredImage: json['featuredImage'] as String?,
      excerpt: json['excerpt'] as String?,
      newsCategory: json['category'] != null
          ? NewsCategory.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      author: json['author'] != null
          ? NewsAuthor.fromJson(json['author'] as Map<String, dynamic>)
          : null,
      count: json['_count'] != null
          ? NewsCount.fromJson(json['_count'] as Map<String, dynamic>)
          : null,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => NewsComment.fromJson(e as Map<String, dynamic>))
          .toList(),
      likes: (json['likes'] as List<dynamic>?)
          ?.map((e) => NewsLike.fromJson(e as Map<String, dynamic>))
          .toList(),
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : null,
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
    );
  }

  News toEntity() {
    return News(
      id: id,
      title: title,
      content: content,
      tags: tags,
      viewsCount: viewsCount,
      excerpt: excerpt,
      isPublished: isPublished,
      isPromotedToHero: isPromotedToHero,
      newsCategoryId: newsCategoryId,
      authorId: authorId,
      featuredImage: featuredImage,
      newsCategory: newsCategory,
      author: author,
      count: count,
      comments: comments,
      likes: likes,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
