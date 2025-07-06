import 'package:esl/core/error/exceptions.dart';
import 'package:esl/core/networks/dio_client.dart';
import 'package:esl/features/library/data/datasources/resource_endpoint.dart';
import 'package:esl/features/library/data/models/director_model.dart';
import 'package:esl/features/library/data/models/library_model.dart';
import 'package:esl/features/library/domain/entities/author.dart';
import 'package:esl/features/library/domain/entities/department.dart';
import 'package:esl/features/library/domain/entities/library_news.dart';
import 'package:esl/features/library/domain/entities/research.dart';
import 'package:esl/features/library/domain/entities/resource.dart';

abstract class ResourceRemoteDataSource {
  Future<Resource> getResources();
  Future<List<Author>> getAuthors();
  Future<List<Author>> getResourceByAuthors();
  Future<List<Department>> getResourceByDepartment();
  Future<List<Research>> getResourceByCategory();
  Future<LibraryNews> getNews();
}

class ResourceRemoteDataSourceImpl implements ResourceRemoteDataSource {
  final DioClient dioClient;
  ResourceRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Resource> getResources() async {
    try {
      final response = await dioClient.get(
        libraryEndpoint,
        fromJsonT: (json) {
          if (json == null) {
            throw ServerException('Library data is null');
          }
          return Resource.fromJson(json as Map<String, dynamic>);
        },
      );

      return response.data!;
    } catch (e) {
      throw Exception('Error fetching resources: $e');
    }
  }

  @override
  Future<List<Author>> getAuthors() async {
    try {
      final response = await dioClient.get(
        authorEndpoint,
        fromJsonT: (json) {
          // Handle the new API response structure with data wrapper
          if (json is Map<String, dynamic> && json.containsKey('data')) {
            final data = json['data'] as List<dynamic>;
            return List<Author>.from(
              data.map(
                (authorJson) => Author.fromJson(authorJson as Map<String, dynamic>),
              ),
            );
          } else if (json is List) {
            // Handle the old API response structure
            return List<Author>.from(
              json.map(
                (authorJson) => Author.fromJson(authorJson as Map<String, dynamic>),
              ),
            );
          } else {
            throw Exception('Unexpected response format for authors');
          }
        },
      );
      return response.data!;
    } catch (e) {
      throw Exception('Error fetching authors: $e');
    }
  }

  @override
  Future<List<Author>> getResourceByAuthors() async {
    try {
      final response = await dioClient.get(
        resourceByAuthorsEndpoint,
        fromJsonT: (json) {
          // Handle the new API response structure with data wrapper
          if (json is Map<String, dynamic> && json.containsKey('data')) {
            final data = json['data'] as List<dynamic>;
            return List<Author>.from(
              data.map(
                (authorJson) => Author.fromJson(authorJson as Map<String, dynamic>),
              ),
            );
          } else if (json is List) {
            // Handle the old API response structure
            return List<Author>.from(
              json.map(
                (authorJson) => Author.fromJson(authorJson as Map<String, dynamic>),
              ),
            );
          } else {
            throw Exception('Unexpected response format for authors');
          }
        },
      );

      return response.data!;
    } catch (e) {
      throw Exception('Error fetching resources: $e');
    }
  }

  @override
  Future<List<Research>> getResourceByCategory() async {
    try {
      final response = await dioClient.get(
        resourceByCategoryEndpoint,
        fromJsonT: (json) {
          // Handle the new API response structure with data wrapper
          if (json is Map<String, dynamic> && json.containsKey('data')) {
            final data = json['data'];
            if (data is Map<String, dynamic> &&
                data.containsKey('publications') &&
                data.containsKey('journals')) {
              return [
                Research(
                  category: 'PUBLICATION',
                  resources: (data['publications'] as List<dynamic>)
                      .map((item) => LibraryModel.fromJson(item as Map<String, dynamic>).toEntity())
                      .toList(),
                ),
                Research(
                  category: 'JOURNAL',
                  resources: (data['journals'] as List<dynamic>)
                      .map((item) => LibraryModel.fromJson(item as Map<String, dynamic>).toEntity())
                      .toList(),
                ),
              ];
            }
          }
          // Fallback to old structure
          if (json is List) {
            return List<Research>.from(
              json.map(
                (researchJson) => Research.fromJson(researchJson as Map<String, dynamic>),
              ),
            );
          }
          throw Exception('Unexpected response format for categories');
        },
      );
      return response.data!;
    } catch (e) {
      throw Exception('Error fetching resources: $e');
    }
  }

  @override
  Future<List<Department>> getResourceByDepartment() async {
    try {
      final response = await dioClient.get(
        resourceByDepartmentEndpoint,
        fromJsonT: (json) {
          // Handle the new API response structure with data wrapper
          if (json is Map<String, dynamic> && json.containsKey('data')) {
            final data = json['data'] as List<dynamic>;
            return List<Department>.from(
              data.map(
                (directorJson) {
                  final director = DirectorModel.fromJson(
                    directorJson as Map<String, dynamic>,
                  );
                  // Convert DirectorModel to Department
                  return Department(
                    id: director.id,
                    departmentId: director.dceoId,
                    name: director.title,
                    facultyId: director.userId,
                    imageUrl: '', // Director response doesn't have image
                    resources: director.library,
                  );
                },
              ),
            );
          } else if (json is List) {
            // Handle the old API response structure
            return List<Department>.from(
              json.map(
                (departmentJson) =>
                    Department.fromJson(departmentJson as Map<String, dynamic>),
              ),
            );
          } else {
            throw Exception('Unexpected response format for departments');
          }
        },
      );

      return response.data!;
    } catch (e) {
      throw Exception('Error fetching resources: $e');
    }
  }

  @override
  Future<LibraryNews> getNews() async {
    try {
      final response = await dioClient.get(
        newsEndpoint,
        fromJsonT: (json) {
          if (json == null) {
            throw ServerException('Library news is null');
          }
          return LibraryNews.fromJson(json as Map<String, dynamic>);
        },
      );

      return response.data!;
    } catch (e) {
      throw Exception('Error fetching resources: $e');
    }
  }
}
