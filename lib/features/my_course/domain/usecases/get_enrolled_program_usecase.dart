import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/my_course/data/models/enrolled_program_model.dart';
import 'package:esl/features/my_course/domain/repositories/my_course_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetEnrolledProgramUseCase extends UseCase<List<EnrolledProgramModel>, NoParams> {
  final MyCourseRepository _gradeRepository;

  GetEnrolledProgramUseCase(this._gradeRepository);

  @override
  Future<Either<Failure, List<EnrolledProgramModel>>> call(NoParams params) {
    return _gradeRepository.getEnrolledProgram();
  }
}
