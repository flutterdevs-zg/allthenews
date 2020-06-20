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
          return DefaultException();
        case DioErrorType.RESPONSE:
          return _fromStatusCode(error.response.statusCode);
        default:
          return DefaultException();
      }
    } else {
      return DefaultException();
    }
  }

  ApiException _fromStatusCode(int code) {
    switch (code) {
      case 401:
        return UnauthorizedException(code);
      default:
        return DefaultException();
    }
  }
}
