
class ServerException implements Exception {
  final String message;
  final Map<String, dynamic>? errorDetails;

  ServerException([this.message = 'Server error occurred', this.errorDetails]);

  @override
  String toString() {
    return message;
  }
}

class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'Cache error occurred']);

  @override
  String toString() => message;
}
