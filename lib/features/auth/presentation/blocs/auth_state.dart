part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => <Object>[];
}

class AuthInitial extends AuthState {}

class AuthChecking extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object> get props => <Object>[user];
}

class AuthSignUpSuccess extends AuthState {
  final String message;

  const AuthSignUpSuccess({this.message = 'Account created successfully! Please log in.'});

  @override
  List<Object> get props => <Object>[message];
}

class AuthUnsupportedRoleLogout extends AuthState {
  final String message;

  const AuthUnsupportedRoleLogout({this.message = 'Your user type is not supported on this app. You have been logged out.'});

  @override
  List<Object> get props => <Object>[message];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object> get props => <Object>[error];
}

class AuthLogOutSuccess extends AuthState {
  const AuthLogOutSuccess();

  @override
  List<Object> get props => <Object>[];
}
