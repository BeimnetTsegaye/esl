import 'package:esl/features/gallery/domain/entities/gallery.dart';

class GalleryModel extends Gallery {
  const GalleryModel({required super.category, required super.items});

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      category: json['category'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => GalleryItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Gallery toEntity() {
    return Gallery(category: category, items: items);
  }
}

class GalleryItems {
  final String id;
  final String mediaUrl;
  final String mediaType;
  final String title;
  const GalleryItems({required this.id, required this.mediaUrl, required this.mediaType, required this.title});
  factory GalleryItems.fromJson(Map<String, dynamic> json) {
    return GalleryItems(
      id: json['id'] as String,
      mediaUrl: json['media_url'] as String,
      mediaType: json['mediaType'] as String,
      title: json['title'] as String,
    );
  }
}
