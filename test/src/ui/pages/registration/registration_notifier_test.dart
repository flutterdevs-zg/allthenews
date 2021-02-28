import 'package:allthenews/src/domain/authentication/authentication_api_exception.dart';
import 'package:allthenews/src/domain/authentication/authentication_repository.dart';
import 'package:allthenews/src/ui/common/message_provider.dart';
import 'package:allthenews/src/ui/pages/authentication/registration/registration_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../common/change_notifier_test_util.dart';

class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}

class MockAuthenticationMessageProvider extends Mock implements MessageProvider {}

class MockFieldMessageProvider extends Mock implements MessageProvider {}

void main() {
  RegistrationNotifier registrationNotifier;
  MockAuthenticationRepository mockAuthenticationRepository;
  MockAuthenticationMessageProvider mockAuthenticationMessageProvider;
  MockFieldMessageProvider mockFieldMessageProvider;

  const testErrorMessage = "error";
  const testEmail = "email";
  const testPassword = "password";
  const testName = "name";

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    mockAuthenticationMessageProvider = MockAuthenticationMessageProvider();
    mockFieldMessageProvider = MockFieldMessageProvider();
    registrationNotifier = RegistrationNotifier(
      mockAuthenticationRepository,
      mockAuthenticationMessageProvider,
      mockFieldMessageProvider,
    );
  });

  group('notifier tests', () {
    test('should register successfully', () {
      registrationNotifier.updatePassword(testPassword);
      registrationNotifier.updateEmail(testEmail);
      registrationNotifier.updateName(testName);

      when(mockAuthenticationRepository.createUser(testEmail, testPassword))
          .thenAnswer((_) async => Future.value());
      when(mockAuthenticationRepository.updateUser(testName))
          .thenAnswer((_) async => Future.value());

      registrationNotifier.verifyStateInOrder(
        testFunction: registrationNotifier.validateFieldsAndCreateUser,
        matchersMethods: [
          () {
            expect(registrationNotifier.state.isLoading, true);
            expect(registrationNotifier.state.authenticationError, null);
            expect(registrationNotifier.state.emailError, null);
            expect(registrationNotifier.state.passwordError, null);
            expect(registrationNotifier.state.nameError, null);
            expect(registrationNotifier.state.email, testEmail);
            expect(registrationNotifier.state.password, testPassword);
            expect(registrationNotifier.state.name, testName);
          },
          () {
            verifyInOrder([
              mockAuthenticationRepository.createUser(testEmail, testPassword),
              mockAuthenticationRepository.updateUser(testName)
            ]);
            expect(registrationNotifier.state.isLoading, false);
            expect(registrationNotifier.state.authenticationError, null);
            expect(registrationNotifier.state.emailError, null);
            expect(registrationNotifier.state.passwordError, null);
            expect(registrationNotifier.state.nameError, null);
            expect(registrationNotifier.state.email, "");
            expect(registrationNotifier.state.password, "");
            expect(registrationNotifier.state.name, "");
          }
        ],
      );
    });

    test('should set field error registration state', () {
      when(mockFieldMessageProvider.getMessage(any)).thenReturn(testErrorMessage);

      registrationNotifier.verifyStateInOrder(
        testFunction: registrationNotifier.validateFieldsAndCreateUser,
        matchersMethods: [
          () {
            verifyZeroInteractions(mockAuthenticationRepository);
            expect(registrationNotifier.state.isLoading, false);
            expect(registrationNotifier.state.authenticationError, null);
            expect(registrationNotifier.state.passwordError, testErrorMessage);
            expect(registrationNotifier.state.emailError, testErrorMessage);
            expect(registrationNotifier.state.nameError, testErrorMessage);
            expect(registrationNotifier.state.email, "");
            expect(registrationNotifier.state.password, "");
            expect(registrationNotifier.state.name, "");
          }
        ],
      );
    });

    test('should return error when creating user', () {
      registrationNotifier.updatePassword(testPassword);
      registrationNotifier.updateEmail(testEmail);
      registrationNotifier.updateName(testName);

      when(mockAuthenticationRepository.createUser(testEmail, testPassword))
          .thenAnswer((_) async => Future.error(ConnectionException()));
      when(mockAuthenticationMessageProvider.getMessage(any)).thenReturn(testErrorMessage);

      registrationNotifier.verifyStateInOrder(
        testFunction: registrationNotifier.validateFieldsAndCreateUser,
        matchersMethods: [
          () {
            expect(registrationNotifier.state.isLoading, true);
            expect(registrationNotifier.state.authenticationError, null);
            expect(registrationNotifier.state.passwordError, null);
            expect(registrationNotifier.state.emailError, null);
            expect(registrationNotifier.state.nameError, null);
            expect(registrationNotifier.state.email, testEmail);
            expect(registrationNotifier.state.password, testPassword);
            expect(registrationNotifier.state.name, testName);
          },
          () {
            verify(mockAuthenticationRepository.createUser(testEmail, testPassword));
            verifyNever(mockAuthenticationRepository.updateUser(testName));
            expect(registrationNotifier.state.isLoading, false);
            expect(registrationNotifier.state.authenticationError, testErrorMessage);
            expect(registrationNotifier.state.passwordError, null);
            expect(registrationNotifier.state.emailError, null);
            expect(registrationNotifier.state.nameError, null);
            expect(registrationNotifier.state.email, testEmail);
            expect(registrationNotifier.state.password, testPassword);
            expect(registrationNotifier.state.name, testName);
          }
        ],
      );
    });

    test('should return error when creating user', () {
      registrationNotifier.updatePassword(testPassword);
      registrationNotifier.updateEmail(testEmail);
      registrationNotifier.updateName(testName);

      when(mockAuthenticationRepository.createUser(testEmail, testPassword))
          .thenAnswer((_) async => Future.value());
      when(mockAuthenticationRepository.updateUser(testName))
          .thenAnswer((_) async => Future.error(ConnectionException()));
      when(mockAuthenticationMessageProvider.getMessage(any)).thenReturn(testErrorMessage);

      registrationNotifier.verifyStateInOrder(
        testFunction: registrationNotifier.validateFieldsAndCreateUser,
        matchersMethods: [
          () {
            expect(registrationNotifier.state.isLoading, true);
            expect(registrationNotifier.state.authenticationError, null);
            expect(registrationNotifier.state.passwordError, null);
            expect(registrationNotifier.state.emailError, null);
            expect(registrationNotifier.state.nameError, null);
            expect(registrationNotifier.state.email, testEmail);
            expect(registrationNotifier.state.password, testPassword);
            expect(registrationNotifier.state.name, testName);
          },
          () {
            verify(mockAuthenticationRepository.createUser(testEmail, testPassword));
            verify(mockAuthenticationRepository.updateUser(testName));
            expect(registrationNotifier.state.isLoading, false);
            expect(registrationNotifier.state.authenticationError, testErrorMessage);
            expect(registrationNotifier.state.passwordError, null);
            expect(registrationNotifier.state.emailError, null);
            expect(registrationNotifier.state.nameError, null);
            expect(registrationNotifier.state.email, testEmail);
            expect(registrationNotifier.state.password, testPassword);
            expect(registrationNotifier.state.name, testName);
          }
        ],
      );
    });
  });
}
