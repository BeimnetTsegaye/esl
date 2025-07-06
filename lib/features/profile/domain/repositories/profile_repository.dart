import 'package:esl/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProfileRepository {
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
