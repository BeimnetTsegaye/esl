import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/program/domain/entities/program.dart';
import 'package:esl/features/program/domain/repositories/program_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetProgramsUseCase extends UseCase<List<Program>, NoParams> {
  final ProgramRepository repository;

  GetProgramsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Program>>> call(NoParams params) {
    return repository.getPrograms();
  }
}
