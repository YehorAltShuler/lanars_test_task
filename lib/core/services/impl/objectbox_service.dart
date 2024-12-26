import '../../../objectbox.g.dart';
import '../../common/user/user.dart';

class ObjectboxService {
  static ObjectboxService? _instance;
  late final Store _store;

  ObjectboxService._internal(this._store);

  static ObjectboxService get instance {
    if (_instance == null) {
      throw Exception(
          'ObjectboxService не инициализирован. Вызовите initialize() перед использованием.');
    }
    return _instance!;
  }

  static Future<void> initialize() async {
    if (_instance != null) return;

    final store = await openStore();
    _instance = ObjectboxService._internal(store);
  }

  Box<T> _getBox<T>() => _store.box<T>();

  User? getUser() {
    final box = _getBox<User>();
    return box.isEmpty() ? null : box.getAll().first;
  }

  void saveUser(User user) {
    final box = _getBox<User>();
    if (box.isEmpty()) {
      box.put(user);
    } else {
      final existingUser = box.getAll().first;
      box.put(existingUser.copyWith(
        username: user.username,
        email: user.email,
        profilePictureUrl: user.profilePictureUrl,
      ));
    }
  }

  void deleteUser() {
    final box = _getBox<User>();
    if (!box.isEmpty()) {
      box.removeAll();
    }
  }

  // void close() {
  //   _store.close();
  // }
}
