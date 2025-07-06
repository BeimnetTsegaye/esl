import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/auth/domain/entities/user.dart';
import 'package:esl/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LogInWithGoogleUseCase extends UseCase<User, NoParams> {
  final AuthRepository authRepository;

  LogInWithGoogleUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return authRepository.loginWithGoogle();
  }
}
