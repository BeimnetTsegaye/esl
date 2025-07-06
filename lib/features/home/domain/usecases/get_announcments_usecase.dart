import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/home/domain/entities/announcment.dart';
import 'package:esl/features/home/domain/repositories/announcment_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAnnouncmentsUsecase extends UseCase<List<Announcment>, NoParams> {
  final AnnouncmentRepository repository;

  GetAnnouncmentsUsecase(this.repository);

  @override
  Future<Either<Failure, List<Announcment>>> call(NoParams params) async {
    return await repository.getAnnouncments();
  }
}
