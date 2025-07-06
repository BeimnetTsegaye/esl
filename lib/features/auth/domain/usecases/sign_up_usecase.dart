import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/auth/domain/entities/user.dart';
import 'package:esl/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_usecase.freezed.dart';

class SignUpUseCase extends UseCase<User, Params> {
  final AuthRepository authRepository;

  SignUpUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await authRepository.signUp(
      params.email,
      params.password,
      params.phoneNumber,
      params.firstName,
      params.lastName,
    );
  }
}

@freezed
abstract class Params with _$Params {
  const factory Params({
    required String email,
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) = _Params;
}
