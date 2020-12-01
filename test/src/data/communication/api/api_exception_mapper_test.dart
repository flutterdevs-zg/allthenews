import 'dart:io';

import 'package:allthenews/src/data/communication/api/api_exception_mapper.dart';
import 'package:allthenews/src/domain/communication/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ApiExceptionMapper apiExceptionMapper;

  setUp(() {
    apiExceptionMapper = ApiExceptionMapper();
  });

  group('api exception mappings tests', () {
    test(
      'should return a server error exception when status code is equal to 500',
      () {
        final communicationException = DioError(type: DioErrorType.RESPONSE, response: Response(statusCode: 500));

        final domainException = apiExceptionMapper.toExceptionType(communicationException);

        expect(domainException, isA<ServerErrorException>());
      },
    );

    test(
      'should throw a socket exception when there is no internet connection',
      () {
        final communicationException = DioError(error: const SocketException(''));

        final domainException = apiExceptionMapper.toExceptionType(communicationException);

        expect(domainException, isA<ConnectionException>());
      },
    );

    test(
      'should throw an unauthorized exception when status code is equal to 401',
      () {
        final communicationException = DioError(type: DioErrorType.RESPONSE, response: Response(statusCode: 401));

        final domainException = apiExceptionMapper.toExceptionType(communicationException);

        expect(domainException, isA<UnauthorizedException>());
      },
    );

    test(
      'should throw an invalid url exception when status code is equal to 404',
      () {
        final communicationException = DioError(type: DioErrorType.RESPONSE, response: Response(statusCode: 404));

        final domainException = apiExceptionMapper.toExceptionType(communicationException);

        expect(domainException, isA<InvalidUrlException>());
      },
    );
  });
}
