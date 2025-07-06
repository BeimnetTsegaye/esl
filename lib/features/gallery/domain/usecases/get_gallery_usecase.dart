import 'package:esl/core/error/failure.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/gallery/domain/entities/gallery.dart';
import 'package:esl/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetGalleryUseCase extends UseCase<List<Gallery>, NoParams> {
  final GalleryRepository repository;

  GetGalleryUseCase(this.repository);

  @override
  Future<Either<Failure, List<Gallery>>> call(NoParams params) async {
    return await repository.getGallery();
  }
}
