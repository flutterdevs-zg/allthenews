import 'package:allthenews/src/data/communication/api/ny_times_repositor.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/domain/authorization/api_key.dart';
import 'package:allthenews/src/domain/authorization/api_key_repository.dart';
import 'package:allthenews/src/domain/model/article.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class _Urls {
  static const baseUrl = "https://api.nytimes.com/svc/";
  static const mostPopular = "mostpopular/v2/emailed/7.json";
}

class NYTimesRepositoryImpl extends NYTimesRepository {
  final Dio _dio = inject<Dio>();
  ApiKeyRepository _apiKeyRepository = inject<ApiKeyRepository>();
  ApiKey _apiKey;

  NYTimesRepositoryImpl() {
    _dio.options.baseUrl = _Urls.baseUrl;

    final verboseLogging = kDebugMode;

    _dio.interceptors
      ..add(
        InterceptorsWrapper(onRequest: _onRequest),
      )
      ..add(
        PrettyDioLogger(
          requestHeader: verboseLogging,
          requestBody: verboseLogging,
          responseHeader: verboseLogging,
          responseBody: verboseLogging,
          maxWidth: 300,
        ),
      );
  }

  _onRequest(RequestOptions options) async {
    if (_apiKey == null) {
      _apiKey = await _apiKeyRepository.getKey();
    }
    options.queryParameters = {"api-key": _apiKey.value};
  }

  Future<Article> getFirstMostPopularArticle() async {
    final response = await _dio.get<dynamic>(_Urls.mostPopular);
    return Article.fromJson(response.data['results'][0]);
  }
}
