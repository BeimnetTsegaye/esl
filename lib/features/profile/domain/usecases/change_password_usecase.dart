import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_usecase.freezed.dart';

class ChangePasswordUseCase extends UseCase<void, ChangePasswordParams> {
  final ProfileRepository _userRepository;

  ChangePasswordUseCase(this._userRepository);

  @override
  Future<Either<Failure, void>> call(ChangePasswordParams params) {
    return _userRepository.changePassword(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
    );
  }
}

@freezed
abstract class ChangePasswordParams with _$ChangePasswordParams {
  const factory ChangePasswordParams({
    required String currentPassword,
    required String newPassword,
  }) = _ChangePasswordParams;
}
