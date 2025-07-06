import 'package:esl/core/error/failure.dart';
import 'package:esl/core/networks/network_info.dart';
import 'package:esl/features/library/data/datasources/resource_remote_datasource.dart';
import 'package:esl/features/library/domain/entities/author.dart';
import 'package:esl/features/library/domain/entities/department.dart';
import 'package:esl/features/library/domain/entities/library_news.dart';
import 'package:esl/features/library/domain/entities/research.dart';
import 'package:esl/features/library/domain/entities/resource.dart';
import 'package:esl/features/library/domain/repositories/resource_repository.dart';
import 'package:fpdart/fpdart.dart';

class ResourceRepositoryImpl implements ResourceRepository {
  final ResourceRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ResourceRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Resource>> getResources() async {
    try {
      final resources = await remoteDataSource.getResources();
      return Right(resources);
    } catch (e) {
      if (await networkInfo.isConnected) {
        return Left(ServerFailure(message: e.toString()));
      } else {
        return const Left(NetworkFailure(message: 'No internet connection'));
      }
    }
  }

  @override
  Future<Either<Failure, List<Author>>> getAuthors() async {
    if (await networkInfo.isConnected) {
      try {
        final authors = await remoteDataSource.getAuthors();
        return Right(authors);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Future.value(
        const Left(NetworkFailure(message: 'No internet connection')),
      );
    }
  }

  @override
  Future<Either<Failure, List<Author>>> getResourceByAuthors() async {
    try {
      final resources = await remoteDataSource.getResourceByAuthors();
      return Right(resources);
    } catch (e) {
      if (await networkInfo.isConnected) {
        return Left(ServerFailure(message: e.toString()));
      } else {
        return const Left(NetworkFailure(message: 'No internet connection'));
      }
    }
  }

  @override
  Future<Either<Failure, List<Research>>> getResourceByCategory() async {
    try {
      final resources = await remoteDataSource.getResourceByCategory();
      return Right(resources);
    } catch (e) {
      if (await networkInfo.isConnected) {
        return Left(ServerFailure(message: e.toString()));
      } else {
        return const Left(NetworkFailure(message: 'No internet connection'));
      }
    }
  }

  @override
  Future<Either<Failure, List<Department>>> getResourceByDepartment() async {
    try {
      final resources = await remoteDataSource.getResourceByDepartment();
      return Right(resources);
    } catch (e) {
      if (await networkInfo.isConnected) {
        return Left(ServerFailure(message: e.toString()));
      } else {
        return const Left(NetworkFailure(message: 'No internet connection'));
      }
    }
  }

  @override
  Future<Either<Failure, LibraryNews>> getNews() async {
    try {
      final news = await remoteDataSource.getNews();
      return Right(news);
    } catch (e) {
      if (await networkInfo.isConnected) {
        return Left(ServerFailure(message: e.toString()));
      } else {
        return const Left(NetworkFailure(message: 'No internet connection'));
      }
    }
  }
}
