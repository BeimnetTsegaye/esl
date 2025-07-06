import 'package:equatable/equatable.dart';
import 'package:esl/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ChangePasswordUseCase _changePasswordUseCase;
  ProfileBloc({required ChangePasswordUseCase changePasswordUseCase})
    : _changePasswordUseCase = changePasswordUseCase,
      super(ProfileInitial()) {
    on<ChangePassword>(_onChangePassword);
  }

  Future<void> _onChangePassword(
    ChangePassword event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ChangePasswordLoading());
    final result = await _changePasswordUseCase(
      ChangePasswordParams(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      ),
    );

    result.fold(
      (failure) {
        emit(
          ChangePasswordError(
            message: failure.message ?? 'Failed to change password',
          ),
        );
      },
      (_) {
        emit(
          const ChangePasswordSuccess(message: 'Password changed successfully'),
        );
      },
    );
  }
}
