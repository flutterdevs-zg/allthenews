import 'dart:io';

import 'package:allthenews/src/data/communication/api/api_exception_mapper.dart';
import 'package:allthenews/src/domain/communication/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ApiExceptionMapper apiExceptionMapper;

  setUpAll(() {
    apiExceptionMapper = ApiExceptionMapper();
  });

  group('api exception mappings tests', () {
    final inputsToMatchers = {
      DioError(type: DioErrorType.response, response: Response(statusCode: 500)): isA<ServerErrorException>(),
      DioError(error: const SocketException('')): isA<ConnectionException>(),
      DioError(type: DioErrorType.response, response: Response(statusCode: 401)): isA<UnauthorizedException>(),
      DioError(type: DioErrorType.response, response: Response(statusCode: 404)): isA<InvalidUrlException>(),
    };
    inputsToMatchers.forEach((input, matcher) {
      test("$input -> $matcher", () {
        expect(apiExceptionMapper.toDomainException(input), matcher);
      });
    });
  });
}
