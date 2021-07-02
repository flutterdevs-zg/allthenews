import 'dart:convert';

import 'package:allthenews/src/app/app_config.dart';
import 'package:allthenews/src/data/communication/api/api_exception_mapper.dart';
import 'package:allthenews/src/data/communication/api/http_client.dart';
import 'package:allthenews/src/data/communication/api/request.dart';
import 'package:allthenews/src/domain/authorization/api_key_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../api_stubs/api_stubs_reader.dart';
import 'http_client_test.mocks.dart';

@GenerateMocks([
  ApiExceptionMapper,
  AppConfig,
  ApiKeyRepository,
  Dio,
  BaseOptions,
  Interceptors,
])
void main() {
  late HttpClient httpClient;
  late MockBaseOptions mockOptions;
  late MockInterceptors mockInterceptors;
  late MockDio mockDio;
  late MockAppConfig mockAppConfig;
  late MockApiExceptionMapper mockApiExceptionMapper;
  late MockApiKeyRepository mockApiKeyRepository;

  setUpAll(() {
    mockOptions = MockBaseOptions();
    mockInterceptors = MockInterceptors();
    mockDio = MockDio();
    mockAppConfig = MockAppConfig();
    mockApiExceptionMapper = MockApiExceptionMapper();
    mockApiKeyRepository = MockApiKeyRepository();

    when(mockAppConfig.baseUrl).thenReturn("");
    when(mockDio.options).thenReturn(mockOptions);
    when(mockDio.interceptors).thenReturn(mockInterceptors);

    httpClient = HttpClient(
        mockDio, mockAppConfig, mockApiKeyRepository, mockApiExceptionMapper);
  });

  group('communication tests', () {
    test(
      'should return a map response when status code is equal to 200',
      () async {
        when(mockDio.get<dynamic>(any,
                queryParameters: anyNamed('queryParameters')))
            .thenAnswer(
          (_) async => Response(
              data: json.decode(findApiStubBy('most_popular_news.json')),
              statusCode: 200,
              requestOptions: RequestOptions(path: "")),
        );

        final response = await httpClient
            .get(Request(path: 'testPath', queryParameters: {}));

        expect(response, isNotNull);
        expect(response, isA<Map<String, dynamic>>());
      },
    );
  });
}
