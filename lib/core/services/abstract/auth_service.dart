import 'package:lanars_test_task/core/common/user/user.dart';
import 'package:retrofit/retrofit.dart';

abstract interface class AuthService {
  Future<HttpResponse<User>> signIn(Map<String, dynamic> body);
}
