part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => <Object>[];
}

class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();

  @override
  List<Object> get props => <Object>[];
}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String phoneNumber;
  final String firstName;
  final String lastName;

  const AuthSignUpRequested({
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object> get props => <Object>[email, password, phoneNumber, firstName, lastName];
}

class AuthLogInRequested extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;

  const AuthLogInRequested({
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  @override
  List<Object> get props => <Object>[email, password, rememberMe];
}

class AuthLogOutRequested extends AuthEvent {
  const AuthLogOutRequested();

  @override
  List<Object> get props => <Object>[];
}
