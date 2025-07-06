import 'package:esl/core/error/failure.dart';
import 'package:esl/core/networks/network_info.dart';
import 'package:esl/features/gallery/data/datasources/gallery_remote_datasource.dart';
import 'package:esl/features/gallery/domain/entities/gallery.dart';
import 'package:esl/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:fpdart/fpdart.dart';

class GalleryRepositoryImpl implements GalleryRepository {
  final GalleryRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GalleryRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Gallery>>> getGallery() async {
    if (await networkInfo.isConnected) {
      try {
        final galleryList = await remoteDataSource.getGallery();
        return Right(galleryList.map((gallery) => gallery.toEntity()).toList());
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return const Left(ServerFailure(message: 'No internet connection'));
    }
  }
}
