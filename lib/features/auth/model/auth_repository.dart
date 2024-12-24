import 'package:lanars_test_task/core/services/auth_service.dart';
import 'package:lanars_test_task/core/services/objectbox_service.dart';

class AuthRepository {
  final ObjectboxService _objectboxService;
  final AuthService _authService;

  AuthRepository(this._objectboxService, this._authService);

  Future<void> signIn(String email, String password) async {
    try {
      final user =
          await _authService.signIn({"email": email, "password": password});
      _objectboxService.saveUser(user);
    } catch (e) {
      rethrow;
    }
  }
}
