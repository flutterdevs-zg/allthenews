class ApiException implements Exception {
  final int code;

  ApiException([this.code]);
}

class UnauthorizedException extends ApiException {
  final int code;

  UnauthorizedException(this.code) : super(code);
}

class DefaultException extends ApiException {}

class ConnectionException extends ApiException {}
