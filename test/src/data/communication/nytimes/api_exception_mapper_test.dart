import 'dart:io';

import 'package:allthenews/src/data/communication/api/api_exception_mapper.dart';
import 'package:allthenews/src/domain/communication/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ApiExceptionMapper apiExceptionMapper;

  setUpAll(() {
    apiExceptionMapper = ApiExceptionMapper();
  });

  group('api exception mappings tests', () {
    final requestOptions = RequestOptions(path: "");
    final inputsToMatchers = {
      DioError(type: DioErrorType.response, response: Response(statusCode: 500,requestOptions: requestOptions),requestOptions: requestOptions): isA<ServerErrorException>(),
      DioError(error: const SocketException(''),requestOptions: requestOptions): isA<ConnectionException>(),
      DioError(type: DioErrorType.response, response: Response(statusCode: 401,requestOptions: requestOptions),requestOptions: requestOptions): isA<UnauthorizedException>(),
      DioError(type: DioErrorType.response, response: Response(statusCode: 404,requestOptions: requestOptions,),requestOptions: requestOptions): isA<InvalidUrlException>(),
    };
    inputsToMatchers.forEach((input, matcher) {
      test("$input -> $matcher", () {
        expect(apiExceptionMapper.toDomainException(input), matcher);
      });
    });
  });
}
