import 'package:dio/dio.dart';
import 'package:lanars_test_task/core/services/impl/objectbox_service.dart';

import '../../../core/exceptions/api_exceptions.dart';
import '../../../core/services/abstract/auth_service.dart';

class AuthRepository {
  final ObjectboxService _objectboxService;
  final AuthService _authService;

  AuthRepository(this._objectboxService, this._authService);

  Future<void> signIn(String email, String password) async {
    try {
      final response =
          await _authService.signIn({"email": email, "password": password});

      switch (response.response.statusCode) {
        case 200:
          final user = response.data;
          _objectboxService.saveUser(user);
          break;

        case 401:
          throw UnauthorizedException("Неверный email или пароль.", 401);

        case 500:
          throw ServerException("Ошибка сервера. Попробуйте позже.", 500);

        default:
          throw UnknownException(
            "Неожиданная ошибка. Статус-код: ${response.response.statusCode}",
            response.response.statusCode,
          );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw NetworkException("Превышено время ожидания соединения.");
      } else if (e.type == DioExceptionType.badResponse) {
        throw ApiException(
          "Ошибка сети: ${e.response?.statusMessage ?? 'Неизвестная ошибка'}",
          e.response?.statusCode,
        );
      } else {
        throw NetworkException("Ошибка сети: ${e.message}");
      }
    } catch (e) {
      throw UnknownException("Произошла неизвестная ошибка: ${e.toString()}");
    }
  }
}
