import 'package:equatable/equatable.dart';

class NewsCategory extends Equatable {
  final String? id;
  final String? category;

  const NewsCategory({this.id, this.category});

  factory NewsCategory.fromJson(Map<String, dynamic> json) {
    return NewsCategory(
      id: json['id'] as String?,
      category: json['category'] as String?,
    );
  }
 
  @override
  List<Object?> get props => [id, category];
}

class NewsCount extends Equatable {
  final int? likes;
  final int? comments;

  const NewsCount({this.likes, this.comments});

  factory NewsCount.fromJson(Map<String, dynamic> json) {
    return NewsCount(
      likes: json['likes'] as int?,
      comments: json['comments'] as int?,
    );
  }
  
  @override
  List<Object?> get props => [likes, comments];
}

class NewsLike extends Equatable {
  final String? id;
  final String? newsId;
  final String? userId;
  final DateTime? createdAt;

  const NewsLike({this.id, this.newsId, this.userId, this.createdAt});

  factory NewsLike.fromJson(Map<String, dynamic> json) {
    return NewsLike(
      id: json['id'] as String?,
      newsId: json['newsId'] as String?,
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [id, newsId, userId, createdAt];
}

class NewsComment extends Equatable {
  final String? id;
  final String? newsId;
  final String? userId;
  final String? content;
  final String? status;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  const NewsComment({
    this.id,
    this.newsId,
    this.userId,
    this.content,
    this.status,
    this.updatedAt,
    this.createdAt,
  });

  factory NewsComment.fromJson(Map<String, dynamic> json) {
    return NewsComment(
      id: json['id'] as String?,
      newsId: json['newsId'] as String?,
      userId: json['userId'] as String?,
      content: json['comment'] as String?,
      status: json['status'] as String?,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [
    id,
    newsId,
    userId,
    content,
    status,
    updatedAt,
    createdAt,
  ];
}

class NewsAuthor extends Equatable {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;

  const NewsAuthor({this.id, this.email, this.firstName, this.lastName});

  factory NewsAuthor.fromJson(Map<String, dynamic> json) {
    return NewsAuthor(
      id: json['id'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, email, firstName, lastName];
}

class News extends Equatable {
  final String? id;
  final String? title;
  final String? excerpt;
  final Map<String, dynamic>? content;
  final List<String>? tags;
  final bool? isPublished;
  final bool? isPromotedToHero;
  final String? newsCategoryId;
  final int? viewsCount;
  final String? authorId;
  final String? featuredImage;
  final NewsCategory? newsCategory;
  final NewsAuthor? author;
  final NewsCount? count;
  final List<NewsComment>? comments;
  final List<NewsLike>? likes;
  final DateTime? startDate;
  final DateTime? endDate;

  const News({
    this.id,
    this.title,
    this.excerpt,
    this.content,
    this.tags,
    this.isPublished,
    this.isPromotedToHero,
    this.newsCategoryId,
    this.authorId,
    this.featuredImage,
    this.viewsCount,
    this.newsCategory,
    this.author,
    this.count,
    this.comments,
    this.likes,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    content,
    tags,
    viewsCount,
    isPublished,
    isPromotedToHero,
    newsCategoryId,
    authorId,
    featuredImage,
    excerpt,
    newsCategory,
    author,
    count,
    comments,
    likes,
    startDate,
    endDate,
  ];
}
