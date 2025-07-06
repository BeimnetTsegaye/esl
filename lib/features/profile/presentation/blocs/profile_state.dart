part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ChangePasswordLoading extends ProfileState {}

class ChangePasswordSuccess extends ProfileState {
  final String message;

  const ChangePasswordSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class ChangePasswordError extends ProfileState {
  final String message;

  const ChangePasswordError({required this.message});

  @override
  List<Object> get props => [message];
}
