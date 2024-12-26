/// Базовый класс для всех исключений API
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() {
    return "ApiException: $message (status code: $statusCode)";
  }
}

/// Исключение для ошибок авторизации
class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message, [super.statusCode]);
}

/// Исключение для ошибок сети
class NetworkException extends ApiException {
  NetworkException(super.message, [super.statusCode]);
}

/// Исключение для серверных ошибок
class ServerException extends ApiException {
  ServerException(super.message, [super.statusCode]);
}

/// Исключение для неизвестных ошибок
class UnknownException extends ApiException {
  UnknownException(super.message, [super.statusCode]);
}

/// Исключение для отсутствия данных в ответе
class NoDataException extends ApiException {
  NoDataException(super.message, [super.statusCode]);
}
