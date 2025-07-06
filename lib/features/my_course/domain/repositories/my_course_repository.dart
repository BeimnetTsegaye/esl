import 'package:esl/core/error/failure.dart';
import 'package:esl/features/my_course/data/models/enrolled_program_model.dart';
import 'package:esl/features/my_course/domain/entities/grade.dart';
import 'package:esl/features/my_course/domain/entities/weekly_schedule.dart';
import 'package:fpdart/fpdart.dart';

abstract class MyCourseRepository {
  Future<Either<Failure, List<EnrolledProgramModel>>> getEnrolledProgram();
  Future<Either<Failure, Grade>> getGrade({String? semester});
  Future<Either<Failure, WeeklySchedule>> getWeeklySchedule();
}
