import 'dart:convert';

import 'package:esl/features/auth/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalDataSource {
  /// gets the cached [UserModel] which was gotten from the last time
  /// the user was logged in.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<UserModel> getCachedUser();

  /// Caches the [UserModel] in the local storage.
  ///
  /// Throws [CacheException] if there is an error while caching the data.
  Future<void> cacheUser(UserModel userModel);

  // ✅ New methods
  Future<void> cacheToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const _tokenKey = 'access_token';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> cacheUser(UserModel userModel) async {
    final jsonString = jsonEncode(userModel.toJson());
    await _secureStorage.write(key: _tokenKey, value: jsonString);
  }

  @override
  Future<UserModel> getCachedUser() async {
    final jsonString = await _secureStorage.read(key: _tokenKey);
    if (jsonString == null) {
      throw Exception('Token not found. User might not be logged in.');
    }
    return UserModel.fromJson(jsonDecode(jsonString));
  }

  /// ✅ Stores token securely
  @override
  Future<void> cacheToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  /// ✅ Retrieves token securely
  @override
  Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  /// ✅ Clears token securely
  @override
  Future<void> clearToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }
}
