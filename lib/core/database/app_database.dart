import 'package:esl/core/database/daos/user_dao.dart';
import 'package:esl/features/auth/data/models/user_model.dart';
import 'package:floor/floor.dart';

@Database(version: 1, entities: [UserModel])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
}
