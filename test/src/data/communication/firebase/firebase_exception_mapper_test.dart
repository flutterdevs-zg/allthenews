import 'package:allthenews/src/data/authentication/firebase_exception_mapper.dart';
import 'package:allthenews/src/domain/authentication/authentication_api_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';

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

void main() {
  late FirebaseExceptionMapper firebaseExceptionMapper;

  setUpAll(() {
    firebaseExceptionMapper = FirebaseExceptionMapper();
  });

  group('api exception mappings tests', () {
    final inputsToMatchers = {
      FirebaseAuthException(code: _Constants.tooManyRequests, message: ""): TooManyRequestsException(),
      FirebaseAuthException(code: _Constants.invalidEmail, message: ""): InvalidEmailException(),
      FirebaseAuthException(code: _Constants.networkError, message: ""): ConnectionException(),
      FirebaseAuthException(code: _Constants.userNotFound, message: ""): UserNotFoundException(),
      FirebaseAuthException(code: _Constants.operationNotAllowed, message: ""): OperationNotAllowedException(),
      FirebaseAuthException(code: _Constants.emailAlreadyInUse, message: ""): EmailAlreadyInUseException(),
      FirebaseAuthException(code: _Constants.userDisabled, message: ""): UserDisabledException(),
      FirebaseAuthException(code: _Constants.wrongPassword, message: ""): InvalidPasswordException(),
      FirebaseAuthException(code: _Constants.weakPassword, message: ""): WeakPasswordException(),
    };

    inputsToMatchers.forEach((input, matcher) {
      test("$input -> $matcher", () {
        expect(firebaseExceptionMapper.toDomainException(input).runtimeType, matcher.runtimeType);
      });
    });
  });
}
