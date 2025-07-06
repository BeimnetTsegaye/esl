import 'package:equatable/equatable.dart';
import 'package:esl/features/library/data/models/library_model.dart';
import 'package:esl/features/library/domain/entities/library.dart';

class Journal extends Equatable {
  final String category;
  final List<Library> resources;

  const Journal({required this.category, required this.resources});

  @override
  List<Object?> get props => [category, resources];
  factory Journal.fromJson(Map<String, dynamic> json) {
    return Journal(
      category: json['category'] as String,
      resources: (json['library'] as List<dynamic>)
          .map(
            (library) => LibraryModel.fromJson(
              library as Map<String, dynamic>,
            ).toEntity(),
          )
          .toList(),
    );
  }
}
