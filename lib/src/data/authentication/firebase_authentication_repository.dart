import 'dart:async';

import 'package:allthenews/src/data/communication/connection/connection_status_provider.dart';
import 'package:allthenews/src/domain/authentication/authentication_api_exception.dart';
import 'package:allthenews/src/domain/authentication/authentication_repository.dart';
import 'package:allthenews/src/domain/communication/connection_status.dart';
import 'package:allthenews/src/domain/communication/exception_mapper.dart';
import 'package:allthenews/src/domain/model/user.dart' as domain;
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationRepository implements AuthenticationRepository {
  final FirebaseAuth _auth;
  final ExceptionMapper _exceptionMapper;
  final ConnectionStatusProvider _connectionStatusProvider;

  FirebaseAuthenticationRepository(
    this._auth,
    this._exceptionMapper,
    this._connectionStatusProvider,
  );

  @override
  Future<void> createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on Exception catch (exception) {
      throw _exceptionMapper.toDomainException(exception);
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      throw _exceptionMapper.toDomainException(error);
    }
  }

  @override
  Future<void> updateUser(String name) async {
    try {
      return await _auth.currentUser?.updateProfile(displayName: name);
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
  Future<Stream<domain.User?>> observeUserChanges() async {
    final connectionStatus = await _connectionStatusProvider.getConnectionStatus();
    if (connectionStatus == ConnectionStatus.none) {
      return Future.error(ConnectionException());
    } else {
      return _auth.userChanges().map((User? user) =>
          user == null ? null : domain.User(email: user.email ?? '', name: user.displayName ?? ''));
    }
  }
}
