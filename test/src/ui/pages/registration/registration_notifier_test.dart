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
    test('should set loaded registration state', () {
      when(mockAuthenticationRepository.createUser(any, any))
          .thenAnswer((_) async => Future.value());
      when(mockAuthenticationRepository.updateUser(any)).thenAnswer((_) async => Future.value());

      registrationNotifier.updatePassword("mock");
      registrationNotifier.updateEmail("mock");
      registrationNotifier.updateName("mock");

      registrationNotifier.verifyStateInOrder(
        testFunction: registrationNotifier.validateFieldsAndCreateUser,
        matchersMethods: [
          () {
            expect(registrationNotifier.state.isLoading, true);
          },
          () {
            verifyInOrder([
              mockAuthenticationRepository.createUser(any, any),
              mockAuthenticationRepository.updateUser(any)
            ]);
            expect(registrationNotifier.state.isLoading, false);
          }
        ],
      );
    });

    test('should set field error registration state', () {
      const errorMessage = "blad";
      when(mockFieldMessageProvider.getMessage(any)).thenReturn(errorMessage);

      registrationNotifier.verifyStateInOrder(
        testFunction: registrationNotifier.validateFieldsAndCreateUser,
        matchersMethods: [
          () {
            expect(registrationNotifier.state.isLoading, true);
          },
          () {
            verifyZeroInteractions(mockAuthenticationRepository);
            expect(registrationNotifier.state.isLoading, false);
            expect(registrationNotifier.state.passwordError, errorMessage);
            expect(registrationNotifier.state.emailError, errorMessage);
            expect(registrationNotifier.state.nameError, errorMessage);
          }
        ],
      );
    });

    test('should return error when creating user', () {
      const errorMessage = "blad";
      registrationNotifier.updatePassword("mock");
      registrationNotifier.updateEmail("mock");
      registrationNotifier.updateName("mock");

      when(mockAuthenticationRepository.createUser(any, any))
          .thenAnswer((_) async => Future.error(ConnectionException()));
      when(mockAuthenticationMessageProvider.getMessage(any)).thenReturn(errorMessage);

      registrationNotifier.verifyStateInOrder(
        testFunction: registrationNotifier.validateFieldsAndCreateUser,
        matchersMethods: [
          () {
            expect(registrationNotifier.state.isLoading, true);
          },
          () {
            verify(mockAuthenticationRepository.createUser(any, any));
            expect(registrationNotifier.state.authenticationError, errorMessage);
            expect(registrationNotifier.state.isLoading, false);
            verifyNever(mockAuthenticationRepository.updateUser(any));
          }
        ],
      );
    });

    test('should return error when creating user', () {
      const errorMessage = "blad";
      registrationNotifier.updatePassword("mock");
      registrationNotifier.updateEmail("mock");
      registrationNotifier.updateName("mock");

      when(mockAuthenticationRepository.createUser(any, any))
          .thenAnswer((_) async => Future.value());
      when(mockAuthenticationRepository.updateUser(any))
          .thenAnswer((_) async => Future.error(ConnectionException()));

      when(mockAuthenticationMessageProvider.getMessage(any)).thenReturn(errorMessage);

      registrationNotifier.verifyStateInOrder(
        testFunction: registrationNotifier.validateFieldsAndCreateUser,
        matchersMethods: [
          () {
            expect(registrationNotifier.state.isLoading, true);
          },
          () {
            verify(mockAuthenticationRepository.createUser(any, any));
            verify(mockAuthenticationRepository.updateUser(any));
            expect(registrationNotifier.state.authenticationError, errorMessage);
            expect(registrationNotifier.state.isLoading, false);
          }
        ],
      );
    });
  });
}
