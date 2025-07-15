import 'dart:convert';
import 'package:esl/core/networks/api_endpoints.dart';
import 'package:esl/features/auth/data/datasources/auth_local_data_source.dart'
    show AuthLocalDataSource;
import 'package:esl/features/library/data/models/news_model.dart' show Comment;
import 'package:http/http.dart' as http;

class NewsRepository {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  NewsRepository({required this.client, required this.authLocalDataSource});
  Future<Comment?> postComment(String newsId, String content) async {
    try {
      final user = await authLocalDataSource.getCachedUser(); // ✅ Fetch user
      final token = user.token; // ✅ Extract token

      if (token == null || token.isEmpty) {
        print('❌ Token not found. User might not be logged in.');
        return null;
      }

      final url = Uri.parse('$baseUrl/news/comment/$newsId');
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'comment': content}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return Comment.fromJson(data['data']);
      } else {
        print('❌ Failed to post comment: ${response.statusCode}');
        print(response.body);
        return null;
      }
    } catch (e) {
      print('❌ Error posting comment: $e');
      return null;
    }
  }
}
