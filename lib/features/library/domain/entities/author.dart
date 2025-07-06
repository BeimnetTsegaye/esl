import 'package:equatable/equatable.dart';
import 'package:esl/features/library/data/models/library_model.dart';
import 'package:esl/features/library/domain/entities/library.dart';

class Author extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final List<Library>? resources;

  const Author({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.resources,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      resources:
          (json['library'] as List<dynamic>?)
              ?.map(
                (resource) => LibraryModel.fromJson(
                  resource as Map<String, dynamic>,
                ).toEntity(),
              )
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [id, firstName, lastName, resources];
}
