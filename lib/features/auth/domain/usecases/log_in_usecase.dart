import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/auth/domain/entities/user.dart';
import 'package:esl/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_in_usecase.freezed.dart';

class LogInUseCase extends UseCase<User, LogInParams> {
  final AuthRepository authRepository;

  LogInUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(LogInParams params) async {
    return await authRepository.login(
      params.email,
      params.password,
      params.rememberMe,
    );
  }
}

@freezed
abstract class LogInParams with _$LogInParams {
  const factory LogInParams({
    required String email,
    required String password,
    required bool rememberMe,
  }) = _LogInParams;
}
