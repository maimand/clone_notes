import 'package:clone_notes/app/data/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

abstract class UserRepository {
  Future<List<UserModel>> getUsers();

  Future<UserModel> register(String username, String password);

  Future<UserModel> login(String username, String password);
}

class RemoteUserRepository implements UserRepository {
  static final databaseInstance = FirebaseDatabase.instance.ref('users');

  @override
  Future<UserModel> login(String username, String password) async {
    final users = await getUsers();
    for(final user in users) {
      if(user.checkIdentity(username, password) != null) {
        return user;
      }
    }
    throw Exception('Username and Password are not correct');
  }

  @override
  Future<UserModel> register(String username, String password) async {
    final users = await getUsers();
    if(users.any((element) => element.username == username)) {
      throw Exception('Username already taken');
    }
    final user = UserModel(
        id: const Uuid().v4(), username: username, password: password);
    final Map<String, Map> updates = {};
    updates['/${user.id}'] = user.toJson();
    await databaseInstance.update(updates);
    return user;
  }

  @override
  Future<List<UserModel>> getUsers() async {
    final data = await databaseInstance.once();
    final mapData = data.snapshot.value;
    if (mapData == null || mapData is! Map) {
      return [];
    }
    final List<UserModel> users = [];
    mapData.forEach((key, values) {
      if (values is Map) {
        users.add(UserModel(
          id: key,
          username: values['username'] ?? '',
          password: values['password'] ?? '',
        ));
      }
    });
    return users;
  }
}
