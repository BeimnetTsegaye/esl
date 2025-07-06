import 'package:esl/core/networks/dio_client.dart';
import 'package:esl/features/gallery/data/models/gallery_model.dart';

abstract class GalleryRemoteDataSource {
  Future<List<GalleryModel>> getGallery();
}

class GalleryRemoteDataSourceImpl implements GalleryRemoteDataSource {
  final DioClient dioClient;
  GalleryRemoteDataSourceImpl({required this.dioClient});
  @override
  Future<List<GalleryModel>> getGallery() async {
    final response = await dioClient.get(
      '/gallery/client',
      fromJsonT: (json) {
        if (json is! List) {
          throw Exception('Expected a list of gallery items');
        }
        return json
            .map(
              (galleryJson) =>
                  GalleryModel.fromJson(galleryJson as Map<String, dynamic>),
            )
            .toList();
      },
    );
    if (!response.success) {
      throw Exception(response.message);
    }
    return response.data ?? [];
  }
}
