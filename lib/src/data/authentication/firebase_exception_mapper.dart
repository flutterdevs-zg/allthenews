import 'package:allthenews/src/domain/communication/exception_mapper.dart';
import 'package:allthenews/src/domain/authentication/authentication_api_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class _Constants {
  static const networkError = "network-request-failed";
  static const invalidEmail = "invalid-email";
  static const emailAlreadyInUse = "email-already-in-use";
  static const operationNotAllowed = "operation-not-allowed";
  static const userDisabled = "user-disabled";
  static const userNotFound = "user-not-found";
  static const wrongPassword = "wrong-password";
  static const weakPassword = "weak-password";
  static const tooManyRequests = "too-many-requests";
}

class FirebaseExceptionMapper extends ExceptionMapper {
  @override
  AuthenticationApiException toDomainException(Object error) {
    if (error is Exception) {
      if (error is FirebaseAuthException) {
        switch (error.code) {
          case _Constants.networkError:
            return ConnectionException();
          case _Constants.invalidEmail:
            return InvalidEmailException();
          case _Constants.emailAlreadyInUse:
            return EmailAlreadyInUseException();
          case _Constants.operationNotAllowed:
            return OperationNotAllowedException();
          case _Constants.userDisabled:
            return UserDisabledException();
          case _Constants.userNotFound:
            return UserNotFoundException();
          case _Constants.wrongPassword:
            return InvalidPasswordException();
          case _Constants.weakPassword:
            return WeakPasswordException();
          case _Constants.tooManyRequests:
            return TooManyRequestsException();
        }
      }
    }
    return AuthUnknownException();
  }
}
