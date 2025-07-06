import 'package:esl/features/library/domain/entities/library.dart';

class LibraryModel extends Library {
  const LibraryModel({
    required super.id,
    required super.title,
    required super.description,
    required super.authorId,
    required super.departmentId,
    super.libraryCategoryId,
    super.publicationDate,
    required super.documentUrl,
    required super.uploaderId,
  });

  factory LibraryModel.fromJson(Map<String, dynamic> json) {
    return LibraryModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      authorId: json['authorId'] as String? ?? json['author_id'] as String? ?? '',
      departmentId: json['departmentId'] as String? ?? json['department_id'] as String? ?? json['directorId'] as String? ?? '',
      libraryCategoryId: json['libraryCategoryId'] as String? ?? json['categoryId'] as String?,
      publicationDate: json['publicationDate'] != null
          ? DateTime.parse(json['publicationDate'] as String)
          : null,
      documentUrl: json['documentUrl'] as String? ?? json['document'] as String? ?? '',
      uploaderId: json['uploaderId'] as String? ?? json['uploader_id'] as String? ?? '',
    );
  }

  Library toEntity() {
    return Library(
      id: id,
      title: title,
      description: description,
      authorId: authorId,
      departmentId: departmentId,
      libraryCategoryId: libraryCategoryId,
      publicationDate: publicationDate,
      documentUrl: documentUrl,
      uploaderId: uploaderId,
    );
  }
}
