import 'dart:convert';
import 'dart:io';

import 'package:allthenews/src/app/app_config.dart';
import 'package:allthenews/src/data/communication/api/api_exception_mapper.dart';
import 'package:allthenews/src/data/communication/api/http_client.dart';
import 'package:allthenews/src/data/communication/api/request.dart';
import 'package:allthenews/src/domain/authorization/api_key_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../api_stubs/api_stubs_reader.dart';

class MockDio extends Mock implements Dio {
  @override
  BaseOptions options = BaseOptions();

  @override
  Interceptors interceptors = Interceptors();
}

class MockApiKeyRepository extends Mock implements ApiKeyRepository {}

class MockAppConfig extends Mock implements AppConfig {
  @override
  final String baseUrl = "";
}

class MockApiExceptionMapper extends Mock implements ApiExceptionMapper {}

void main() {
  HttpClient httpClient;
  MockDio mockDio;
  MockAppConfig mockAppConfig;
  MockApiExceptionMapper mockApiExceptionMapper;
  MockApiKeyRepository mockApiKeyRepository;

  setUp(() {
    mockDio = MockDio();
    mockAppConfig = MockAppConfig();
    mockApiExceptionMapper = MockApiExceptionMapper();
    httpClient = HttpClient(mockDio, mockAppConfig, mockApiKeyRepository, mockApiExceptionMapper);
  });

  group('communication tests', () {
    test(
      'should return a map response when status code is equal to 200',
      () async {
        when(mockDio.get<dynamic>(any, queryParameters: anyNamed('queryParameters'))).thenAnswer(
          (_) async => Response(data: json.decode(findApiStubBy('most_popular_news.json')), statusCode: 200),
        );

        final response = await httpClient.get(Request(path: 'testPath', queryParameters: {}));

        expect(response, isNot(null));
        expect(response, isA<Map<String, dynamic>>());
      },
    );
  });
}
