import 'package:allthenews/src/data/authentication/firebase_authentication_repository.dart';
import 'package:allthenews/src/data/communication/connection/connection_status_provider.dart';
import 'package:allthenews/src/domain/authentication/authentication_api_exception.dart';
import 'package:allthenews/src/domain/authentication/authentication_repository.dart';
import 'package:allthenews/src/domain/communication/connection_status.dart';
import 'package:allthenews/src/domain/communication/exception_mapper.dart';
import 'package:allthenews/src/domain/model/user.dart' as domain;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firebase_authentication_repository_test.mocks.dart';

@GenerateMocks([FirebaseAuth, ExceptionMapper, ConnectionStatusProvider, User, UserCredential])
void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockExceptionMapper mockExceptionMapper;
  late MockConnectionStatusProvider mockConnectionStatusProvider;
  late AuthenticationRepository authenticationRepository;
  late MockUserCredential mockUserCredential;

  const testEmail = "email";
  const testPassword = "password";

  setUp(() {
    mockUserCredential = MockUserCredential();
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
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: testEmail, password: testPassword))
          .thenAnswer((_) => Future.value(mockUserCredential));

      authenticationRepository.createUser(testEmail, testPassword);
      verifyZeroInteractions(mockExceptionMapper);
    });

    test("signs in successfully", () {
      when(mockFirebaseAuth.signInWithEmailAndPassword(email: testEmail, password: testPassword))
          .thenAnswer((_) => Future.value(mockUserCredential));

      authenticationRepository.signIn(testEmail, testPassword);
      verifyZeroInteractions(mockExceptionMapper);
    });

    test("throws error when signing in fails", () {
      final firebaseException = FirebaseAuthException(message: "no connection", code: "");
      when(mockFirebaseAuth.signInWithEmailAndPassword(email: testEmail, password: testPassword))
          .thenAnswer((_) => Future.error(firebaseException));

      when(mockExceptionMapper.toDomainException(firebaseException))
          .thenReturn(ConnectionException());

      expect(authenticationRepository.signIn(testEmail, testPassword),
          throwsA(isInstanceOf<ConnectionException>()));
    });

    test("updates user successfully", () {
      final User testUser = MockUser();
      const testUserName = "tomek";
      when(mockFirebaseAuth.currentUser).thenReturn(testUser);

      authenticationRepository.updateUser(testUserName);
      verify(testUser.updateDisplayName(testUserName)).called(1);
      verifyZeroInteractions(mockExceptionMapper);
    });

    test("gets user when observing the stream", () async {
      final User testUser = MockUser();
      when(mockConnectionStatusProvider.getConnectionStatus()).thenAnswer((answer) {
        return Future.value(ConnectionStatus.mobile);
      });
      when(mockFirebaseAuth.userChanges()).thenAnswer((_) => Stream.value(testUser));
      when(testUser.email).thenReturn("email");
      when(testUser.displayName).thenReturn("imie");

      final userStream = await authenticationRepository.observeUserChanges();

      expect(userStream, emits(isInstanceOf<domain.User>()));
    });

    test("throws error when observing user stream with no connection", () {
      when(mockConnectionStatusProvider.getConnectionStatus()).thenAnswer((answer) {
        return Future.value(ConnectionStatus.none);
      });

      final userStream = authenticationRepository.observeUserChanges;

      expect(userStream, throwsA(isInstanceOf<ConnectionException>()));
      verifyZeroInteractions(mockFirebaseAuth);
    });
  });
}
