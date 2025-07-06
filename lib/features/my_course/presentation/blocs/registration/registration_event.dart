part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class ApplyEvent extends RegistrationEvent {
  final Application application;

  const ApplyEvent(this.application);

  @override
  List<Object> get props => [application];
}
