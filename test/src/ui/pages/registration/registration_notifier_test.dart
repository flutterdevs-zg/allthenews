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

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    mockAuthenticationMessageProvider = MockAuthenticationMessageProvider();
    registrationNotifier = RegistrationNotifier(
      mockAuthenticationRepository,
      mockAuthenticationMessageProvider,
      mockFieldMessageProvider,
    );

    registrationNotifier.updatePassword("mock");
    registrationNotifier.updateEmail("mock");
    registrationNotifier.updateName("mock");
  });

  group('notifier tests', () {
    test('should emit loaded registration state when registering new user', () {
      when(mockAuthenticationRepository.createUser(any, any)).thenAnswer((_) async => Future.value());
      when(mockAuthenticationRepository.updateUser(any)).thenAnswer((_) async => Future.value());

      registrationNotifier.verifyStateInOrder(
        registrationNotifier.validateFieldsAndCreateUser,
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
}
