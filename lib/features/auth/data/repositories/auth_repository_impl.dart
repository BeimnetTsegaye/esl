import 'package:esl/core/error/exceptions.dart';
import 'package:esl/core/error/failure.dart';
import 'package:esl/core/networks/network_info.dart';
import 'package:esl/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:esl/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:esl/features/auth/domain/entities/user.dart';
import 'package:esl/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, User>> signUp(
    String email,
    String password,
    String phoneNumber,
    String firstName,
    String lastName,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.signUp(
          email,
          password,
          phoneNumber,
          firstName,
          lastName,
        );

        // ✅ Cache the newly signed-up user
        await localDataSource.cacheUser(result);

        return Right(result.toEntity());
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.message, errorDetails: e.errorDetails),
        );
      }
    } else {
      try {
        final userModel = await localDataSource.getCachedUser();
        return Right(userModel.toEntity());
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, User>> resetPassword(String email) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  @override
  Future<Either<Failure, User>> login(
    String email,
    String password,
    bool rememberMe,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.login(
          email,
          password,
          rememberMe,
        );

        // ✅ Cache the logged-in user
        await localDataSource.cacheUser(result);

        return Right(result.toEntity());
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.message, errorDetails: e.errorDetails),
        );
      }
    } else {
      try {
        final userModel = await localDataSource.getCachedUser();
        return Right(userModel.toEntity());
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      await remoteDataSource.logOut();
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, errorDetails: e.errorDetails),
      );
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, User>> updateProfile(User user) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> checkAuth() async {
    try {
      final result = await remoteDataSource.checkAuth();
      return Right(result.toEntity());
    } on ServerException catch (e) {
      if (e.message.contains('No access token provided') == true ||
          e.message.contains('Unauthorized') == true) {
        try {
          final refreshResult = await refreshToken();
          if (refreshResult.isRight()) {
            final success = refreshResult.getOrElse((_) => false);
            if (success) {
              // After successful refresh, try checkAuth again
              try {
                final newResult = await remoteDataSource.checkAuth();
                return Right(newResult.toEntity());
              } on ServerException catch (e) {
                return Left(
                  ServerFailure(
                    message: e.message,
                    errorDetails: e.errorDetails,
                  ),
                );
              }
            }
          }
          return const Left(ServerFailure(message: 'Not authenticated'));
        } catch (_) {
          return const Left(ServerFailure(message: 'Not authenticated'));
        }
      }
      return Left(
        ServerFailure(message: e.message, errorDetails: e.errorDetails),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> refreshToken() async {
    try {
      final result = await remoteDataSource.refreshToken();
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, errorDetails: e.errorDetails),
      );
    }
  }

  @override
  Future<Either<Failure, User>> loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }
}
