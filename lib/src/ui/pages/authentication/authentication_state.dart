import 'package:allthenews/src/domain/model/user.dart';

class AuthenticationState {
  final bool isLoading;
  final User? user;
  final String? error;

  const AuthenticationState({
    this.isLoading = false,
    this.user,
    this.error,
  });
}
