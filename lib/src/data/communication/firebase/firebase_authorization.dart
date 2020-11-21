import 'dart:async';

import 'package:allthenews/src/domain/authorization/authorization.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthorization implements Authorization {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<UserCredential> createUser(String email, String password) async =>
      auth.createUserWithEmailAndPassword(email: email, password: password);

  @override
  Future<UserCredential> signIn(String email, String password) async =>
      auth.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future<void> updateUser(String name) async => auth.currentUser.updateProfile(displayName: name);

  @override
  Future<void> logout() => auth.signOut();

  @override
  Stream<User> userStream() => auth.userChanges();
}
