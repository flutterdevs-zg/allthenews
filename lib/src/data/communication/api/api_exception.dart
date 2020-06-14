import 'dart:io';

import 'package:dio/dio.dart';

enum ApiExceptionType {
  defaultError,
  noInternetConnection,
  unknownError,
  unauthorized,
}

class ApiException implements Exception {
  final ApiExceptionType errorType;
  final int code;

  ApiException(this.errorType, this.code);

  static ApiException fromException(Exception exception) {
    if (exception is DioError) {
      return fromDioError(exception);
    } else {
      return ApiException(ApiExceptionType.unknownError, 0);
    }
  }

  static ApiException fromDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.DEFAULT:
        if (error.error is SocketException) {
          return ApiException(ApiExceptionType.noInternetConnection, 0);
        }
        return ApiException(ApiExceptionType.defaultError, 0);
      case DioErrorType.RESPONSE:
        return fromStatusCode(error.response.statusCode);
      default:
        return ApiException(ApiExceptionType.unknownError, 0);
    }
  }

  static ApiException fromStatusCode(int code) {
    switch (code) {
      case 401:
        return ApiException(ApiExceptionType.unauthorized, code);
      default:
        return ApiException(ApiExceptionType.defaultError, code);
    }
  }
}
