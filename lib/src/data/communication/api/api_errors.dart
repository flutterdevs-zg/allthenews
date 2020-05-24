abstract class ApiError {
  final int _statusCode;
  final String _message;

  ApiError(this._message, [this._statusCode]);

  @override
  String toString() => 'message: $_message,statusCode: $_statusCode';
}

class BadRequestError extends ApiError {
  BadRequestError(statusCode, [message = "Bad request error"]) : super(message, statusCode);
}

class ServerError extends ApiError {
  ServerError(statusCode, [message = "Server error"]) : super(message, statusCode);
}

class TimeoutError extends ApiError {
  TimeoutError(statusCode, [message = "Timeout error"]) : super(message, statusCode);
}

class ConnectionError extends ApiError {
  ConnectionError([message = "Connection error"]) : super(message);
}

class EmptyResponseError extends ApiError {
  EmptyResponseError(statusCode, [message = "Empty response error"]) : super(message, statusCode);
}

class UnknownError extends ApiError {
  UnknownError([message = "Unknown request"]) : super(message);
}
