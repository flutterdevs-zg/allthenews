import 'package:allthenews/src/domain/authentication/authentication_repository.dart';
import 'package:allthenews/src/ui/common/message_provider.dart';
import 'package:allthenews/src/ui/pages/authentication/login/login_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../common/change_notifier_test_util.dart';

class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}

class MockAuthenticationMessageProvider extends Mock implements MessageProvider {}

class MockFieldMessageProvider extends Mock implements MessageProvider {}

void main() {
  LoginNotifier loginNotifier;
  MockAuthenticationRepository mockAuthenticationRepository;
  MockAuthenticationMessageProvider mockAuthenticationMessageProvider;
  MockFieldMessageProvider mockFieldMessageProvider;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();

    loginNotifier = LoginNotifier(
      mockAuthenticationRepository,
      mockAuthenticationMessageProvider,
      mockFieldMessageProvider,
    );

    loginNotifier.updateEmail("email");
    loginNotifier.updatePassword("password");
  });

  group('notifier tests', () {
    test('should emit loaded login state when user logs in', () {
      when(mockAuthenticationRepository.signIn(any, any)).thenAnswer((_) async => Future.value());

      loginNotifier.verifyStateInOrder(
        loginNotifier.validateFieldsAndSignIn,
        [
          () {
            expect(loginNotifier.state.isLoading, true);
          },
          () {
            verify(mockAuthenticationRepository.signIn(any, any));
            expect(loginNotifier.state.isLoading, false);
          }
        ],
      );
    });
  });
}
