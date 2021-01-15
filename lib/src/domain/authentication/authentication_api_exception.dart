import 'package:allthenews/src/domain/common/error/all_the_news_exception.dart';

class AuthenticationApiException extends AllTheNewsException {}

class ConnectionException extends AuthenticationApiException {}

class InvalidEmailException extends AuthenticationApiException {}

class UserDisabledException extends AuthenticationApiException {}

class UserNotFoundException extends AuthenticationApiException {}

class InvalidPasswordException extends AuthenticationApiException {}

class EmailAlreadyInUseException extends AuthenticationApiException {}

class OperationNotAllowedException extends AuthenticationApiException {}

class WeakPasswordException extends AuthenticationApiException {}

class TooManyRequestsException extends AuthenticationApiException {}

class AuthUnknownException extends AuthenticationApiException {}
