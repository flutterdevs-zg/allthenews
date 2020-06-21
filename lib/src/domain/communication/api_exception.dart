class ApiException implements Exception {
  final int code;

  ApiException([this.code]);
}

class UnauthorizedException extends ApiException {}

class ServerErrorException extends ApiException {}

class InvalidUrlException extends ApiException {}

class UnknownException extends ApiException {}

class ConnectionException extends ApiException {}
