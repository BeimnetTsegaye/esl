import 'package:esl/features/auth/data/models/user_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class UserDao{
  /// Gets the cached [UserModel] which was gotten from the last time
  @Query('SELECT * FROM UserModel')
  Future<List<UserModel>> findAllUsers();
  /// Gets the cached [UserModel] which was gotten from the last time
  /// the user was logged in.
  @Query('SELECT * FROM UserModel WHERE id = :id')
  Future<UserModel?> findUserById(int id);
  /// Caches the [UserModel] in the local storage.
  @insert
  Future<void> insertUser(UserModel user);
  /// Caches the [UserModel] in the local storage.
  @update
  Future<void> updateUser(UserModel user);
  /// Deletes the [UserModel] from the local storage.
  @delete
  Future<void> deleteUser(UserModel user);
}
