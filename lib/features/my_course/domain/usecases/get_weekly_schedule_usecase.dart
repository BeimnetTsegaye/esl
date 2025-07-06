import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/my_course/domain/entities/weekly_schedule.dart';
import 'package:esl/features/my_course/domain/repositories/my_course_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetWeeklyScheduleUseCase extends UseCase<WeeklySchedule, NoParams> {
  final MyCourseRepository repository;

  GetWeeklyScheduleUseCase(this.repository);

  @override
  Future<Either<Failure, WeeklySchedule>> call(NoParams params) async {
    return await repository.getWeeklySchedule();
  }
}
