import 'package:allthenews/src/domain/authentication/authentication_api_exception.dart';
import 'package:allthenews/src/domain/authentication/authentication_repository.dart';
import 'package:allthenews/src/ui/common/message_provider.dart';
import 'package:allthenews/src/ui/pages/authentication/login/login_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../common/change_notifier_test_util.dart';

class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}

class MockAuthenticationMessageProvider extends Mock implements MessageProvider {}

class MockFieldErrorMessageProvider extends Mock implements MessageProvider {}

void main() {
  LoginNotifier loginNotifier;
  MockAuthenticationRepository mockAuthenticationRepository;
  MockAuthenticationMessageProvider mockAuthenticationMessageProvider;
  MockFieldErrorMessageProvider mockFieldErrorMessageProvider;

  const testErrorMessage = "error";
  const testEmail = "email";
  const testPassword = "password";

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    mockAuthenticationMessageProvider = MockAuthenticationMessageProvider();
    mockFieldErrorMessageProvider = MockFieldErrorMessageProvider();
    loginNotifier = LoginNotifier(
      mockAuthenticationRepository,
      mockAuthenticationMessageProvider,
      mockFieldErrorMessageProvider,
    );
  });

  group("login notifier test group", () {
    test("should log in successfully", () {
      loginNotifier.updateEmail(testEmail);
      loginNotifier.updatePassword(testPassword);

      when(mockAuthenticationRepository.signIn(any, any)).thenAnswer((_) => Future.value());

      loginNotifier.verifyStateInOrder(
        testFunction: loginNotifier.validateFieldsAndSignIn,
        matchersMethods: [
          () {
            expect(loginNotifier.state.isLoading, true);
            expect(loginNotifier.state.authenticationError, null);
            expect(loginNotifier.state.emailError, null);
            expect(loginNotifier.state.passwordError, null);
            expect(loginNotifier.state.email, testEmail);
            expect(loginNotifier.state.password, testPassword);
          },
          () {
            verify(mockAuthenticationRepository.signIn(testEmail, testPassword));
            expect(loginNotifier.state.isLoading, false);
            expect(loginNotifier.state.authenticationError, null);
            expect(loginNotifier.state.emailError, null);
            expect(loginNotifier.state.passwordError, null);
            expect(loginNotifier.state.email, "");
            expect(loginNotifier.state.password, "");

            verifyZeroInteractions(mockAuthenticationMessageProvider);
            verifyZeroInteractions(mockFieldErrorMessageProvider);
          }
        ],
      );
    });

    test('should set validation error when credentials fields are empty', () {
      when(mockFieldErrorMessageProvider.getMessage(any)).thenReturn(testErrorMessage);

      loginNotifier.verifyStateInOrder(
        testFunction: loginNotifier.validateFieldsAndSignIn,
        matchersMethods: [
          () {
            verifyZeroInteractions(mockAuthenticationRepository);
            expect(loginNotifier.state.isLoading, false);
            expect(loginNotifier.state.authenticationError, null);
            expect(loginNotifier.state.passwordError, testErrorMessage);
            expect(loginNotifier.state.emailError, testErrorMessage);
            expect(loginNotifier.state.email, "");
            expect(loginNotifier.state.password, "");
          }
        ],
      );
    });

    test('should return error when signing in', () {
      loginNotifier.updatePassword(testPassword);
      loginNotifier.updateEmail(testEmail);

      when(mockAuthenticationRepository.signIn(any, any))
          .thenAnswer((_) async => Future.error(ConnectionException()));
      when(mockAuthenticationMessageProvider.getMessage(any)).thenReturn(testErrorMessage);

      loginNotifier.verifyStateInOrder(
        testFunction: loginNotifier.validateFieldsAndSignIn,
        matchersMethods: [
          () {
            expect(loginNotifier.state.isLoading, true);
            expect(loginNotifier.state.authenticationError, null);
            expect(loginNotifier.state.passwordError, null);
            expect(loginNotifier.state.emailError, null);
            expect(loginNotifier.state.email, testEmail);
            expect(loginNotifier.state.password, testPassword);
          },
          () {
            verify(mockAuthenticationRepository.signIn(testEmail, testPassword));
            expect(loginNotifier.state.isLoading, false);
            expect(loginNotifier.state.authenticationError, testErrorMessage);
            expect(loginNotifier.state.passwordError, null);
            expect(loginNotifier.state.emailError, null);
            expect(loginNotifier.state.email, testEmail);
            expect(loginNotifier.state.password, testPassword);
          }
        ],
      );
    });
  });
}
