import 'package:equatable/equatable.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/auth/domain/entities/user.dart';
import 'package:esl/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:esl/features/auth/domain/usecases/log_in_usecase.dart';
import 'package:esl/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:esl/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _signUpUseCase;
  final LogInUseCase _signInUseCase;
  final LogOutUseCase _logOutUseCase;
  final CheckAuthUseCase _checkAuthUseCase;
  AuthBloc({
    required SignUpUseCase signUpUseCase,
    required LogInUseCase signInUseCase,
    required LogOutUseCase logOutUseCase,
    required CheckAuthUseCase checkAuthUseCase,
  }) : _signUpUseCase = signUpUseCase,
       _signInUseCase = signInUseCase,
       _logOutUseCase = logOutUseCase,
       _checkAuthUseCase = checkAuthUseCase,
       super(AuthInitial()) {
    on<AuthSignUpRequested>(_onSignUp);
    on<AuthLogInRequested>(_onLogIn);
    on<AuthLogOutRequested>(_onLogOut);
    on<AuthCheckRequested>(_onCheckAuth);
  }

  Future<void> _onSignUp(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await _signUpUseCase
        .call(
          Params(
            email: event.email,
            password: event.password,
            phoneNumber: event.phoneNumber,
            firstName: event.firstName,
            lastName: event.lastName,
          ),
        )
        .then((result) {
          result.fold(
            (failure) =>
                emit(AuthFailure(failure.message ?? 'An error occurred')),
            (user) => emit(const AuthSignUpSuccess()),
          );
        })
        .catchError((dynamic e) {
          emit(AuthFailure(e.toString()));
        });
  }

  Future<void> _onLogIn(
    AuthLogInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await _signInUseCase(
          LogInParams(
            email: event.email,
            password: event.password,
            rememberMe: event.rememberMe,
          ),
        )
        .then((result) {
          result.fold(
            (failure) =>
                emit(AuthFailure(failure.message ?? 'An error occurred')),
            (user) {
              if (user.role != 'USER' && user.role != 'STUDENT' && user.role != 'ADMIN') {
                emit(const AuthFailure('This user type is not supported on this app. Please login with a supported user type.'));
              } else {
                emit(Authenticated(user));
              }
            },
          );
        })
        .catchError((dynamic e) {
          emit(AuthFailure(e.toString()));
        });
  }

  Future<void> _onLogOut(
    AuthLogOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await _logOutUseCase(NoParams())
        .then((result) {
          result.fold(
            (failure) =>
                emit(AuthFailure(failure.message ?? 'An error occurred')),
            (_) => emit(const AuthLogOutSuccess()),
          );
        })
        .catchError((dynamic e) {
          emit(AuthFailure(e.toString()));
        });
  }

  Future<void> _onCheckAuth(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthChecking());
    try {
      final result = await _checkAuthUseCase(NoParams());

      result.fold(
        (failure) => emit(AuthFailure(failure.message ?? 'Not authenticated')),
        (user) {
          if (user.role != 'USER' && user.role != 'STUDENT') {
            // Automatically log out users with unsupported roles
            _handleUnsupportedRoleLogout(emit);
          } else {
            emit(Authenticated(user));
          }
        },
      );
    } catch (e) {
      emit(const AuthFailure('Not authenticated'));
    }
  }

  Future<void> _handleUnsupportedRoleLogout(Emitter<AuthState> emit) async {
    try {
      final logoutResult = await _logOutUseCase(NoParams());
      if (!emit.isDone) {
        logoutResult.fold(
          (failure) => emit(AuthFailure(failure.message ?? 'Logout failed')),
          (_) => emit(const AuthUnsupportedRoleLogout()),
        );
      }
    } catch (e) {
      if (!emit.isDone) {
        emit(AuthFailure('Logout failed: $e'));
      }
    }
  }
}
