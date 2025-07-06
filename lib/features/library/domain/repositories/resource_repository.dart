import 'package:esl/core/error/failure.dart';
import 'package:esl/features/library/domain/entities/author.dart';
import 'package:esl/features/library/domain/entities/department.dart';
import 'package:esl/features/library/domain/entities/library_news.dart';
import 'package:esl/features/library/domain/entities/research.dart';
import 'package:esl/features/library/domain/entities/resource.dart';
import 'package:fpdart/fpdart.dart';

abstract class ResourceRepository {
  Future<Either<Failure, Resource>> getResources();
  Future<Either<Failure, List<Author>>> getAuthors();
  Future<Either<Failure, List<Author>>> getResourceByAuthors();
  Future<Either<Failure, List<Department>>> getResourceByDepartment();
  Future<Either<Failure, List<Research>>> getResourceByCategory();
  Future<Either<Failure, LibraryNews>> getNews();
}
