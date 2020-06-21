import 'dart:io';

import 'package:allthenews/src/domain/communication/api_exception.dart';
import 'package:allthenews/src/domain/communication/exception_mapper.dart';
import 'package:dio/dio.dart';

class ApiExceptionMapper extends ExceptionMapper {
  @override
  ApiException toExceptionType(Object error) {
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.DEFAULT:
          if (error.error is SocketException) {
            return ConnectionException();
          }
          return UnknownException();
        case DioErrorType.RESPONSE:
          return _fromStatusCode(error.response.statusCode);
        default:
          return UnknownException();
      }
    } else {
      return UnknownException();
    }
  }

  ApiException _fromStatusCode(int code) {
    if (code == 401) {
      return UnauthorizedException();
    } else if (code == 404) {
      return InvalidUrlException();
    } else if (code >= 500 && code < 600) {
      return ServerErrorException();
    } else {
      return UnknownException();
    }
  }
}
