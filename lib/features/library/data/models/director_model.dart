import 'package:esl/features/library/data/models/library_model.dart';
import 'package:esl/features/library/domain/entities/library.dart';

class DirectorModel {
  final String id;
  final String title;
  final String dceoId;
  final String userId;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Library> library;

  DirectorModel({
    required this.id,
    required this.title,
    required this.dceoId,
    required this.userId,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.library,
  });

  factory DirectorModel.fromJson(Map<String, dynamic> json) {
    return DirectorModel(
      id: json['id'] as String,
      title: json['title'] as String,
      dceoId: json['dceoId'] as String,
      userId: json['userId'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      library: (json['library'] as List<dynamic>?)
              ?.map(
                (libraryJson) => LibraryModel.fromJson(
                  libraryJson as Map<String, dynamic>,
                ).toEntity(),
              )
              .toList() ??
          [],
    );
  }
} 