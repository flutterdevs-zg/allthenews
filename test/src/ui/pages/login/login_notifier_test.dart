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
      loginNotifier.updateEmail("email");
      loginNotifier.updatePassword("password");

      when(mockAuthenticationRepository.signIn(any, any)).thenAnswer((_) => Future.value());

      loginNotifier.verifyStateInOrder(
        testFunction: loginNotifier.validateFieldsAndSignIn,
        matchersMethods: [
          () {
            expect(loginNotifier.state.isLoading, true);
          },
          () {
            verify(mockAuthenticationRepository.signIn(any, any)).called(1);
            expect(loginNotifier.state.isLoading, false);
            expect(loginNotifier.state.authenticationError, null);

            verifyZeroInteractions(mockAuthenticationMessageProvider);
            verifyZeroInteractions(mockFieldErrorMessageProvider);
          }
        ],
      );
    });

    test('should set validation error when credentials fields are empty', () {
      const errorMessage = "blad";
      when(mockFieldErrorMessageProvider.getMessage(any)).thenReturn(errorMessage);

      loginNotifier.verifyStateInOrder(
        testFunction: loginNotifier.validateFieldsAndSignIn,
        matchersMethods: [
          () {
            expect(loginNotifier.state.isLoading, true);
          },
          () {
            verifyZeroInteractions(mockAuthenticationRepository);
            expect(loginNotifier.state.isLoading, false);
            expect(loginNotifier.state.passwordError, errorMessage);
            expect(loginNotifier.state.emailError, errorMessage);
          }
        ],
      );
    });

    test('should return error when signing in', () {
      const errorMessage = "blad";
      loginNotifier.updatePassword("mock");
      loginNotifier.updateEmail("mock");

      when(mockAuthenticationRepository.signIn(any, any))
          .thenAnswer((_) async => Future.error(ConnectionException()));
      when(mockAuthenticationMessageProvider.getMessage(any)).thenReturn(errorMessage);

      loginNotifier.verifyStateInOrder(
        testFunction: loginNotifier.validateFieldsAndSignIn,
        matchersMethods: [
          () {
            expect(loginNotifier.state.isLoading, true);
          },
          () {
            verify(mockAuthenticationRepository.signIn(any, any));
            expect(loginNotifier.state.authenticationError, errorMessage);
            expect(loginNotifier.state.isLoading, false);
          }
        ],
      );
    });
  });
}
