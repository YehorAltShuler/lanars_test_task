import 'package:lanars_test_task/core/services/impl/objectbox_service.dart';

import 'user.dart';

class UserRepository {
  final ObjectboxService _objectboxService;

  UserRepository(this._objectboxService);

  User? fetchUser() {
    final user = _objectboxService.getUser();
    return user;
  }

  void clearUser() {
    _objectboxService.deleteUser();
  }
}
