import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/my_course/domain/entities/grade.dart';
import 'package:esl/features/my_course/domain/repositories/my_course_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_grade_usecase.freezed.dart';

class GetGradeUseCase extends UseCase<Grade, GradeParams> {
  final MyCourseRepository repository;

  GetGradeUseCase(this.repository);

  @override
  Future<Either<Failure, Grade>> call(GradeParams params) {
    return repository.getGrade(semester: params.semester);
  }
}

@freezed
abstract class GradeParams with _$GradeParams {
  const factory GradeParams({String? semester}) = _GradeParams;
}
