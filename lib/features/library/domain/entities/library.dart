import 'package:equatable/equatable.dart';

class Library extends Equatable {
  final String id;
  final String title;
  final String description;
  final String authorId;
  final String departmentId;
  final String? libraryCategoryId;
  final DateTime? publicationDate;
  final String documentUrl;
  final String uploaderId;

  const Library({
    required this.id,
    required this.title,
    required this.description,
    required this.authorId,
    required this.departmentId,
    this.libraryCategoryId,
    this.publicationDate,
    required this.documentUrl,
    required this.uploaderId,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    authorId,
    departmentId,
    libraryCategoryId,
    publicationDate,
    documentUrl,
    uploaderId,
  ];
}
