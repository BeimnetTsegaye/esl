class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final Map<String, dynamic>? error;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.error,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    T? data;
    if (json['data'] != null && fromJsonT != null) {
      if (json['data'] is List) {
        data = fromJsonT(json['data']);
      } else {
        data = fromJsonT(json['data']);
      }
    }

    return ApiResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? 'No message provided',
      data: data,
      error: json['error'] as Map<String, dynamic>?,
    );
  }
}
