import 'package:allthenews/src/domain/authorization/authentication_repository.dart';
import 'package:allthenews/src/domain/authorization/firebase_exception_mapper.dart';
import 'package:allthenews/src/ui/pages/authentication/login/login_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationRepository extends Mock implements AuthenticationRepository {}

class MockExceptionMapper extends Mock implements FirebaseExceptionMapper {}

void main() {
  LoginNotifier loginNotifier;
  MockAuthenticationRepository mockAuthenticationRepository;
  MockExceptionMapper mockExceptionMapper;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    mockExceptionMapper = MockExceptionMapper();
    loginNotifier = LoginNotifier(mockAuthenticationRepository, mockExceptionMapper);

    loginNotifier.setEmail("email");
    loginNotifier.setPassword("password");
  });

  group('notifier tests', () {
    test('should emit loaded login state when user logs in', () {
      when(mockAuthenticationRepository.signIn(any, any)).thenAnswer((_) async => Future.value());

      loginNotifier.verifySignIn(
        loginNotifier.signIn,
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

extension on ChangeNotifier {
  void verifySignIn(
    Function(String param1, String param2) testFunction,
    List<Function()> matchersMethods,
  ) {
    int index = 0;
    addListener(() {
      matchersMethods[index]();
      index++;
    });
    testFunction("mock", "mock");
  }
}
