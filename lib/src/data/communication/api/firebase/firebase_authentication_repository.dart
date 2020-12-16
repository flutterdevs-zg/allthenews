import 'dart:async';

import 'package:allthenews/src/domain/authorization/authentication_repository.dart';
import 'package:allthenews/src/domain/communication/exception_mapper.dart';
import 'package:allthenews/src/domain/model/user.dart' as domain;
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationRepository implements AuthenticationRepository {
  final FirebaseAuth _auth;
  final ExceptionMapper _exceptionMapper;

  FirebaseAuthenticationRepository(this._auth, this._exceptionMapper);

  @override
  Future<void> createUser(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on Exception catch (exception) {
      throw _exceptionMapper.toDomainException(exception);
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      throw _exceptionMapper.toDomainException(error);
    }
  }

  @override
  Future<void> updateUser(String name) async {
    try {
      return await _auth.currentUser.updateProfile(displayName: name);
    } on Exception catch (exception) {
      throw _exceptionMapper.toDomainException(exception);
    }
  }

  @override
  Future<void> logout() async {
    try {
      return await _auth.signOut();
    } on Exception catch (exception) {
      throw _exceptionMapper.toDomainException(exception);
    }
  }

  @override
  Stream<domain.User> observeUserChanges() => _auth
      .userChanges()
      .map((User user) => user == null ? null : domain.User(email: user.email, name: user.displayName));
}
