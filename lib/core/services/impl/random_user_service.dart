import 'package:dio/dio.dart';
import 'package:lanars_test_task/core/services/abstract/auth_service.dart';
import 'package:retrofit/retrofit.dart';

import '../../common/user/user.dart';

part 'random_user_service.g.dart';

@RestApi(baseUrl: "https://randomuser.me/api/")
abstract class RandomUserService implements AuthService {
  factory RandomUserService(Dio dio, {String baseUrl}) = _RandomUserService;

  @override
  @GET("/")
  Future<HttpResponse<User>> signIn(@Body() Map<String, dynamic> body);
}
