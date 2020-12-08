import 'dart:async';

import 'package:allthenews/src/domain/authorization/authentication_repository.dart';
import 'package:allthenews/src/domain/model/user.dart' as domain;
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationRepository implements AuthenticationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> createUser(String email, String password) =>
      _auth.createUserWithEmailAndPassword(email: email, password: password);

  @override
  Future<void> signIn(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future<void> updateUser(String name) => _auth.currentUser.updateProfile(displayName: name);

  @override
  Future<void> logout() => _auth.signOut();

  @override
  Stream<domain.User> observeUserChanges() => _auth
      .userChanges()
      .map((User user) => user == null ? null : domain.User(email: user.email, name: user.displayName));
}
