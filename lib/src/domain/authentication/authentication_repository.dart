import 'package:allthenews/src/domain/model/user.dart';

abstract class AuthenticationRepository {
  Future<Stream<User?>> observeUserChanges();

  Future<void> createUser(String email, String password);

  Future<void> signIn(String email, String password);

  Future<void> updateUser(String name);

  Future<void> logout();
}
