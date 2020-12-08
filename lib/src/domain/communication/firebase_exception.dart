import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/communication/all_the_news_exception.dart';
import 'package:flutter/material.dart';

class AuthenticationException extends AllTheNewsException {
  final String message;

  AuthenticationException({@required this.message});
}

class NetworkException extends AuthenticationException {
  NetworkException([String message]) : super(message: message ?? Strings.current.noInternetException);
}

class InvalidEmailException extends AuthenticationException {
  InvalidEmailException([String message]) : super(message: message ?? Strings.current.firebaseInvalidEmailError);
}

class UserDisabledException extends AuthenticationException {
  UserDisabledException([String message]) : super(message: message ?? Strings.current.firebaseUserDisabledError);
}

class UserNotFoundException extends AuthenticationException {
  UserNotFoundException([String message]) : super(message: message ?? Strings.current.firebaseUserNotFoundError);
}

class WrongPasswordException extends AuthenticationException {
  WrongPasswordException([String message]) : super(message: message ?? Strings.current.firebaseInvalidPasswordError);
}

class AuthUnknownException extends AuthenticationException {
  AuthUnknownException([String message]) : super(message: message ?? Strings.current.apiUnknownException);
}

class EmailAlreadyInUseException extends AuthenticationException {
  EmailAlreadyInUseException([String message]) : super(message: message ?? Strings.current.firebaseEmailAlreadyInUseError);
}

class OperationNotAllowedException extends AuthenticationException {
  OperationNotAllowedException([String message]) : super(message: message ?? Strings.current.firebaseOperationNotAllowedError);
}

class WeakPasswordException extends AuthenticationException {
  WeakPasswordException([String message]) : super(message: message ?? Strings.current.firebaseWeakPasswordError);
}

class TooManyRequests extends AuthenticationException {
  TooManyRequests([String message]) : super(message: message ?? Strings.current.firebaseTooManyRequests);
}
