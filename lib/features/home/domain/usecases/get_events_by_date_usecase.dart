import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/home/domain/entities/event.dart';
import 'package:esl/features/home/domain/repositories/event_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_events_by_date_usecase.freezed.dart';

class GetEventsByDateUseCase extends UseCase<List<Event>, GetEventsByDateParams> {
  final EventRepository eventRepository;

  GetEventsByDateUseCase(this.eventRepository);

  @override
  Future<Either<Failure, List<Event>>> call(GetEventsByDateParams params) async {
    return await eventRepository.getEventsByDate(params.date);
  }
}

@freezed
abstract class GetEventsByDateParams with _$GetEventsByDateParams {
  const factory GetEventsByDateParams({
    required DateTime date,
  }) = _GetEventsByDateParams;
}
