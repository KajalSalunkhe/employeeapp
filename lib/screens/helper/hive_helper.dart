import 'package:employeeapp/model/user_model.dart';
import 'package:hive/hive.dart';

class HiveHelper {
  final String _userBoxName = 'userBox';

  Future<List<UserModel>> getUsers() async {
    final box = await Hive.openBox<UserModel>(_userBoxName);
    print("box $box");
    print(box.values);
    if (box.isNotEmpty) {
      return box.values.toList();
    }

    return [];
  }

  Future<void> addUser(UserModel user) async {
    final box = await Hive.openBox<UserModel>(_userBoxName);
    await box.add(user);
  }

  Future<void> updateUser(int index, UserModel updatedUser) async {
    final box = await Hive.openBox<UserModel>(_userBoxName);
    await box.putAt(index, updatedUser);
  }

  Future<void> deleteUser(int index) async {
    final box = await Hive.openBox<UserModel>(_userBoxName);
    await box.deleteAt(index);
  }
}
