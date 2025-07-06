import 'package:equatable/equatable.dart';
import 'package:esl/features/my_course/domain/entities/application.dart';
import 'package:esl/features/my_course/domain/usecases/apply_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final ApplyUseCase _applyUseCase;
  RegistrationBloc({required ApplyUseCase applyUseCase})
    : _applyUseCase = applyUseCase,
      super(RegistrationInitial()) {
    on<ApplyEvent>(_onApplyEvent);
  }

  Future<void> _onApplyEvent(
    ApplyEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading());
    await _applyUseCase.call(event.application).then((result) {
      result.fold(
        (failure) => emit(
          RegistrationError(failure.message ?? 'An unknown error occurred'),
        ),
        (application) => emit(Registered(application)),
      );
    });
  }
}
