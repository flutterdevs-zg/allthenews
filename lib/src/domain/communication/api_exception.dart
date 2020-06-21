class ApiException implements Exception {}

class UnauthorizedException extends ApiException {}

class ServerErrorException extends ApiException {}

class InvalidUrlException extends ApiException {}

class UnknownException extends ApiException {}

class ConnectionException extends ApiException {}
