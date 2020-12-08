import 'package:allthenews/src/domain/authorization/authentication_repository.dart';
import 'package:allthenews/src/domain/authorization/firebase_exception_mapper.dart';
import 'package:allthenews/src/domain/communication/firebase_exception.dart';
import 'package:allthenews/src/ui/pages/authentication/registration/registration_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}

class MockExceptionMapper extends Mock implements FirebaseExceptionMapper {}

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
  RegistrationNotifier registrationNotifier;
  MockAuthenticationRepository mockAuthenticationRepository;
  MockExceptionMapper mockExceptionMapper;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    mockExceptionMapper = MockExceptionMapper();
    registrationNotifier = RegistrationNotifier(mockAuthenticationRepository, mockExceptionMapper);

    registrationNotifier.setPassword("mock");
    registrationNotifier.setEmail("mock");
    registrationNotifier.setName("mock");
  });

  group('notifier tests', () {
    test('should emit loaded registration state when registering new user', () {
      when(mockAuthenticationRepository.createUser(any, any)).thenAnswer((_) async => Future.value());
      when(mockAuthenticationRepository.updateUser(any)).thenAnswer((_) async => Future.value());

      registrationNotifier.verifyCreateUser(
        registrationNotifier.createUser,
        [
          () {
            expect(registrationNotifier.state.isLoading, true);
          },
          () {
            verify(mockAuthenticationRepository.createUser(any, any));
            verify(mockAuthenticationRepository.updateUser(any));
            expect(registrationNotifier.state.isLoading, false);
          }
        ],
      );
    });
  });

  group('should return correct error when registering the user', () {
    final inputsToMatchers = {
      FirebaseAuthException(code: _Constants.tooManyRequests, message: ""): TooManyRequests(""),
      FirebaseAuthException(code: _Constants.invalidEmail, message: ""): InvalidEmailException(""),
      FirebaseAuthException(code: _Constants.networkError, message: ""): NetworkException(""),
      FirebaseAuthException(code: _Constants.userNotFound, message: ""): UserNotFoundException(""),
      FirebaseAuthException(code: _Constants.operationNotAllowed, message: ""): OperationNotAllowedException(""),
      FirebaseAuthException(code: _Constants.emailAlreadyInUse, message: ""): EmailAlreadyInUseException(""),
      FirebaseAuthException(code: _Constants.userDisabled, message: ""): UserDisabledException(""),
      FirebaseAuthException(code: _Constants.wrongPassword, message: ""): WrongPasswordException(""),
      FirebaseAuthException(code: _Constants.weakPassword, message: ""): WeakPasswordException(""),
    };

    inputsToMatchers.forEach((input, matcher) {
      test("$input -> $matcher", () {
        when(mockAuthenticationRepository.createUser(any, any)).thenAnswer((_) async => Future.error(input));
        when(mockExceptionMapper.toDomainException(any)).thenAnswer((_) => matcher);

        registrationNotifier.verifyCreateUser(
          registrationNotifier.createUser,
          [
            () {
              expect(registrationNotifier.state.isLoading, true);
            },
            () {
              expect(registrationNotifier.state.exception.runtimeType, matcher.runtimeType);
            }
          ],
        );
      });
    });
  });
}

extension on ChangeNotifier {
  void verifyCreateUser(
    Function(String param1, String param2, String param3) testFunction,
    List<Function()> matchersMethods,
  ) {
    int index = 0;
    addListener(() {
      matchersMethods[index]();
      index++;
    });
    testFunction("mock", "mock", "mock");
  }
}
