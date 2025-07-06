import 'package:esl/core/error/failure.dart';
import 'package:esl/features/program/domain/entities/program.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProgramRepository {
  Future<Either<Failure, List<Program>>> getPrograms();
}
