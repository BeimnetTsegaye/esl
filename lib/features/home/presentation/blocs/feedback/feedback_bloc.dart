import 'package:esl/features/home/domain/entities/feedback.dart';
import 'package:esl/features/home/domain/usecases/submit_feedback_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final SubmitFeedbackUsecase _submitFeedbackUsecase;
  FeedbackBloc({required SubmitFeedbackUsecase submitFeedbackUsecase})
    : _submitFeedbackUsecase = submitFeedbackUsecase,
      super(InitialFeedbackState()) {
    on<FeedbackSubmitted>(_onFeedbackSubmitted);
  }

  Future<void> _onFeedbackSubmitted(
    FeedbackSubmitted event,
    Emitter<FeedbackState> emit,
  ) async {
    emit(LoadingFeedbackState());
    await _submitFeedbackUsecase.call(event.feedback).then((result) {
      result.fold(
        (failure) => emit(
          ErrorFeedbackState(
            failure.message ?? 'An unknown error occurred(at feedback bloc)',
          ),
        ),
        (feedback) => emit(FeedbackSubmittedState()),
      );
    });
  }
}
