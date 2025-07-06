import 'package:esl/core/error/failure.dart';
import 'package:esl/features/home/domain/entities/announcment.dart';
import 'package:fpdart/fpdart.dart';

abstract class AnnouncmentRepository {
  Future<Either<Failure, List<Announcment>>> getAnnouncments();
}
