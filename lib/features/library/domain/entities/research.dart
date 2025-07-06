import 'package:equatable/equatable.dart';
import 'package:esl/features/library/data/models/library_model.dart';
import 'package:esl/features/library/domain/entities/library.dart';

class Research extends Equatable {
  final String category;
  final List<Library> resources;

  const Research({required this.category, required this.resources});

  @override
  List<Object?> get props => [category, resources];
  factory Research.fromJson(Map<String, dynamic> json) {
    return Research(
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

enum ResearchCategory {
  book('Book'),
  journal('Journal');

  final String name;

  const ResearchCategory(this.name);

  @override
  String toString() => name;
  static ResearchCategory fromString(String name) {
    return ResearchCategory.values.firstWhere(
      (category) => category.name.toLowerCase() == name.toLowerCase(),
      orElse: () => ResearchCategory.book,
    );
  }
}
