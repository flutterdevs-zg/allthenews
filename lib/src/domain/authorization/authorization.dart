import 'package:firebase_auth/firebase_auth.dart';

abstract class Authorization {

  Stream<User> userStream();

  Future<UserCredential> createUser(String email, String password);

  Future<UserCredential> signIn(String email, String password);

  Future<void> updateUser(String name);

  Future<void> logout();
}
