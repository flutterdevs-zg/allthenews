import 'package:allthenews/src/data/authentication/firebase_authentication_repository.dart';
import 'package:allthenews/src/data/communication/connection/connection_status_provider.dart';
import 'package:allthenews/src/domain/authentication/authentication_api_exception.dart';
import 'package:allthenews/src/domain/authentication/authentication_repository.dart';
import 'package:allthenews/src/domain/communication/connection_status.dart';
import 'package:allthenews/src/domain/communication/exception_mapper.dart';
import 'package:allthenews/src/domain/model/user.dart' as domain;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockExceptionMapper extends Mock implements ExceptionMapper {}

class MockConnectionStatusProvider extends Mock implements ConnectionStatusProvider {}

class MockFirebaseUser extends Mock implements User {}

void main() {
  MockFirebaseAuth mockFirebaseAuth;
  MockExceptionMapper mockExceptionMapper;
  MockConnectionStatusProvider mockConnectionStatusProvider;
  AuthenticationRepository authenticationRepository;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockExceptionMapper = MockExceptionMapper();
    mockConnectionStatusProvider = MockConnectionStatusProvider();
    authenticationRepository = FirebaseAuthenticationRepository(
      mockFirebaseAuth,
      mockExceptionMapper,
      mockConnectionStatusProvider,
    );
  });

  group("firebase auth test", () {
    test("creates an user successfully", () {
      when(mockFirebaseAuth.createUserWithEmailAndPassword(email: "email", password: "password"))
          .thenAnswer((realInvocation) => Future.value());

      authenticationRepository.createUser("email", "password");
      verifyZeroInteractions(mockExceptionMapper);
    });

    test("signs in successfully", () {
      when(mockFirebaseAuth.signInWithEmailAndPassword(email: "email", password: "password"))
          .thenAnswer((_) => Future.value());

      authenticationRepository.signIn("email", "password");
      verifyZeroInteractions(mockExceptionMapper);
    });

    test("throws error when signing in fails", () {
      final firebaseException = FirebaseAuthException(message: "no connection");
      when(mockFirebaseAuth.signInWithEmailAndPassword(email: "email", password: "password"))
          .thenAnswer((_) => Future.error(firebaseException));

      when(mockExceptionMapper.toDomainException(firebaseException)).thenReturn(ConnectionException());

      expect(authenticationRepository.signIn("email", "password"), throwsA(isInstanceOf<ConnectionException>()));

    });

    test("updates user successfully", () {
      final User testUser = MockFirebaseUser();
      const testUserName = "tomek";
      when(mockFirebaseAuth.currentUser).thenReturn(testUser);

      authenticationRepository.updateUser(testUserName);
      verify(testUser.updateProfile(displayName: testUserName)).called(1);
      verifyNoMoreInteractions(mockExceptionMapper);
    });

    test("gets user when observing the stream", () async {
      final User testUser = MockFirebaseUser();
      when(mockConnectionStatusProvider.getConnectionStatus()).thenAnswer((answer) {
        return Future.value(ConnectionStatus.mobile);
      });

      when(mockFirebaseAuth.userChanges()).thenAnswer((_) => Stream.value(testUser));
      final userStream = await authenticationRepository.observeUserChanges();

      expect(userStream, emits(isInstanceOf<domain.User>()));
    });

    test("throws error when observing user stream with no connection", () {
      when(mockConnectionStatusProvider.getConnectionStatus()).thenAnswer((answer) {
        return Future.value(ConnectionStatus.none);
      });

      expect(authenticationRepository.observeUserChanges,
          throwsA(isInstanceOf<ConnectionException>()));

      verifyZeroInteractions(mockFirebaseAuth);
    });
  });
}
