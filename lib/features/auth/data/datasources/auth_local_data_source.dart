import 'package:esl/features/auth/data/models/user_model.dart';

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
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource{
  @override
  Future<void> cacheUser(UserModel userModel) {
    // TODO: implement cacheUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getCachedUser() {
    // TODO: implement getCachedUser
    throw UnimplementedError();
  }

}
