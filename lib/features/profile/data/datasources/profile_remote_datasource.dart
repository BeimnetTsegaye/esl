import 'package:esl/core/networks/dio_client.dart';
import 'package:esl/features/profile/data/datasources/profile_endpoints.dart';

abstract class ProfileRemoteDataSource {
  Future<void> changePassword(String currentPassword, String newPassword);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient dioClient;

  ProfileRemoteDataSourceImpl(this.dioClient);

  @override
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    try {
      final response = await dioClient.put(
        changePasswordEndpoint,
        data: {'currentPassword': currentPassword, 'newPassword': newPassword},
      );
      if (!response.success) {
        throw Exception(response.message);
      }
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }
}
