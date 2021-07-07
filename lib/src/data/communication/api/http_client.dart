import 'package:allthenews/src/app/app_config.dart';
import 'package:allthenews/src/data/communication/api/request.dart';
import 'package:allthenews/src/domain/authorization/api_key_repository.dart';
import 'package:allthenews/src/domain/communication/exception_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class _Constants {
  static const logPrintWidthSize = 300;
  static const apiKeyParam = "api-key";
  static const timeoutDuration = Duration(seconds: 15);
}

class HttpClient {
  final Dio _dio;
  final AppConfig _appConfig;
  final ApiKeyRepository _apiKeyRepository;
  final ExceptionMapper _exceptionMapper;

  HttpClient(
    this._dio,
    this._appConfig,
    this._apiKeyRepository,
    this._exceptionMapper,
  ) {
    _dio.options.baseUrl = _appConfig.baseUrl;

    _dio.interceptors
      ..add(
        InterceptorsWrapper(onRequest: _onRequest),
      )
      ..add(
        PrettyDioLogger(
          requestHeader: kDebugMode,
          requestBody: kDebugMode,
          responseHeader: kDebugMode,
          responseBody: kDebugMode,
          maxWidth: _Constants.logPrintWidthSize,
        ),
      );
  }

  Future<void> _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final apiKey = await _apiKeyRepository.getKey();
    if (apiKey == null){
      throw Exception("Api key is not set");
    } else {
      options.queryParameters = {_Constants.apiKeyParam: apiKey.value};
      handler.next(options);
    }
  }

  Future<dynamic> get(Request request) async {
    try {
      final Future<Response> futureResponse = _dio.get<dynamic>(
        request.path,
        queryParameters: request.queryParameters,
      );
      final response = await futureResponse.timeout(_Constants.timeoutDuration);
      return response.data;
    } on Exception catch (exception) {
      return Future.error(_exceptionMapper.toDomainException(exception));
    }
  }
}
