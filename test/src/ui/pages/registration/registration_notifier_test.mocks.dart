// Mocks generated by Mockito 5.0.10 from annotations
// in allthenews/test/src/ui/pages/registration/registration_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:allthenews/src/domain/authentication/authentication_repository.dart'
    as _i2;
import 'package:allthenews/src/domain/model/user.dart' as _i4;
import 'package:allthenews/src/ui/common/message_provider.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [AuthenticationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthenticationRepository extends _i1.Mock
    implements _i2.AuthenticationRepository {
  MockAuthenticationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i3.Stream<_i4.User?>> observeUserChanges() => (super.noSuchMethod(
          Invocation.method(#observeUserChanges, []),
          returnValue:
              Future<_i3.Stream<_i4.User?>>.value(Stream<_i4.User?>.empty()))
      as _i3.Future<_i3.Stream<_i4.User?>>);
  @override
  _i3.Future<void> createUser(String? email, String? password) =>
      (super.noSuchMethod(Invocation.method(#createUser, [email, password]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> signIn(String? email, String? password) =>
      (super.noSuchMethod(Invocation.method(#signIn, [email, password]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> updateUser(String? name) =>
      (super.noSuchMethod(Invocation.method(#updateUser, [name]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i3.Future<void>);
  @override
  _i3.Future<void> logout() =>
      (super.noSuchMethod(Invocation.method(#logout, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i3.Future<void>);
}

/// A class which mocks [MessageProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockMessageProvider<T> extends _i1.Mock
    implements _i5.MessageProvider<T> {
  MockMessageProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String getMessage(T? identifier) =>
      (super.noSuchMethod(Invocation.method(#getMessage, [identifier]),
          returnValue: '') as String);
}
