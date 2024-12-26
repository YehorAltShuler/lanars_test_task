import 'package:dio/dio.dart';
import '../../../core/exceptions/api_exceptions.dart';
import '../../../core/services/abstract/feeds_service.dart';
import '../viewModel/feed.dart';

class FeedsRepository {
  final FeedsService _feedsService;

  FeedsRepository(this._feedsService);

  Future<List<Feed>> getFeeds({int perPage = 50, int page = 1}) async {
    try {
      final response = await _feedsService.getFeeds(
        perPage: perPage,
        page: page,
      );

      if (response.data.feeds.isEmpty) {
        throw NoDataException("Данные не найдены.");
      }

      return response.data.feeds;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException(
          "Неавторизованный запрос. Проверьте API-ключ.",
          401,
        );
      } else if (e.response?.statusCode == 500) {
        throw ServerException("Ошибка сервера. Попробуйте позже.", 500);
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw NetworkException("Превышено время ожидания соединения.");
      } else {
        throw ApiException(
          "Ошибка сети: ${e.response?.statusMessage ?? e.message}",
          e.response?.statusCode,
        );
      }
    } catch (e) {
      throw UnknownException("Произошла неизвестная ошибка: ${e.toString()}");
    }
  }
}
