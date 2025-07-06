import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class RefreshTokenUseCase extends UseCase<bool, NoParams> {
  final AuthRepository authRepository;

  RefreshTokenUseCase(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return authRepository.refreshToken();
  }
}
