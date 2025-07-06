import 'package:esl/core/error/failure.dart';
import 'package:esl/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(
    String email,
    String password,
    bool rememberMe,
  );
  Future<Either<Failure, User>> loginWithGoogle();
  Future<Either<Failure, void>> logOut();
  Future<Either<Failure, User>> signUp(
    String email,
    String password,
    String phoneNumber,
    String firstName,
    String lastName,
  );
  Future<Either<Failure, User>> checkAuth();
  Future<Either<Failure, bool>> refreshToken();
  Future<Either<Failure, User>> resetPassword(String email);
  Future<Either<Failure, User>> updateProfile(User user);
}
