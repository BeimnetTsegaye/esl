import 'package:esl/core/error/failure.dart';
import 'package:esl/features/gallery/domain/entities/gallery.dart';
import 'package:fpdart/fpdart.dart';

abstract class GalleryRepository {
  Future<Either<Failure, List<Gallery>>> getGallery();
}
