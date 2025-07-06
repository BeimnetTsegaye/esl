import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/library/domain/entities/department.dart';
import 'package:esl/features/library/domain/repositories/resource_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetResourceByDepartmentUseCase
    extends UseCase<List<Department>, NoParams> {
  final ResourceRepository resourceRepository;

  GetResourceByDepartmentUseCase(this.resourceRepository);

  @override
  Future<Either<Failure, List<Department>>> call(NoParams params) async {
    return await resourceRepository.getResourceByDepartment();
  }
}
