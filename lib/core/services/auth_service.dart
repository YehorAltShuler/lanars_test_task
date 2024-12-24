import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../common/user/user.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: "https://randomuser.me/api/")
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @GET("/")
  Future<User> signIn(@Body() Map<String, dynamic> body);
}
