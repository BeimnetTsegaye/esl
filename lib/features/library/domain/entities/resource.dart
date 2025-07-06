import 'package:equatable/equatable.dart';
import 'package:esl/features/library/data/models/library_model.dart';
import 'package:esl/features/library/domain/entities/author.dart';
import 'package:esl/features/library/domain/entities/department.dart';
import 'package:esl/features/library/domain/entities/library_news.dart';
import 'package:esl/features/library/domain/entities/research.dart';

class Resource extends Equatable {
  final List<Author>? authors;
  final List<Department>? departments;
  final List<Research>? research;
  final LibraryNews? libraryNews;

  const Resource({
    required this.authors,
    this.departments,
    this.research,
    this.libraryNews,
  });

  @override
  List<Object?> get props => [
    authors,
    departments,
    research,
    libraryNews,
  ];
  
  factory Resource.fromJson(Map<String, dynamic> json) {
    // Handle the new API response structure with data wrapper
    Map<String, dynamic> data;
    if (json.containsKey('data')) {
      data = json['data'] as Map<String, dynamic>;
    } else {
      data = json;
    }

    // Process publicationsAndJournal - it's an array of arrays where:
    // index 0 contains publications (PUBLICATION type)
    // index 1 contains journals (JOURNAL type)
    final List<Research> researchList = [];
    if (data['publicationsAndJournal'] is List) {
      final publicationsAndJournal = data['publicationsAndJournal'] as List<dynamic>;
      
      if (publicationsAndJournal.isNotEmpty && publicationsAndJournal[0] is List) {
        // Publications (index 0)
        final publications = publicationsAndJournal[0] as List<dynamic>;
        if (publications.isNotEmpty) {
          researchList.add(Research(
            category: 'PUBLICATION',
            resources: publications
                .map((item) => LibraryModel.fromJson(item as Map<String, dynamic>).toEntity())
                .toList(),
          ));
        }
      }
      
      if (publicationsAndJournal.length > 1 && publicationsAndJournal[1] is List) {
        // Journals (index 1)
        final journals = publicationsAndJournal[1] as List<dynamic>;
        if (journals.isNotEmpty) {
          researchList.add(Research(
            category: 'JOURNAL',
            resources: journals
                .map((item) => LibraryModel.fromJson(item as Map<String, dynamic>).toEntity())
                .toList(),
          ));
        }
      }
    }

    return Resource(
      authors: (data['authors'] as List<dynamic>?)
          ?.map((author) => Author.fromJson(author as Map<String, dynamic>))
          .toList(),
      departments: (data['directors'] as List<dynamic>?)
          ?.map((director) {
            // Convert director to department format
            return Department(
              id: director['id'] as String,
              departmentId: director['dceoId'] as String? ?? '',
              name: director['title'] as String,
              facultyId: director['userId'] as String,
              imageUrl: '', // Director response doesn't have image
              resources: (director['library'] as List<dynamic>?)
                  ?.map((library) => LibraryModel.fromJson(
                      library as Map<String, dynamic>).toEntity())
                  .toList() ?? [],
            );
          })
          .toList(),
      research: researchList.isNotEmpty ? researchList : null,
      libraryNews: data['news'] != null
          ? LibraryNews.fromJson({'news': data['news']})
          : null,
    );
  }
}
