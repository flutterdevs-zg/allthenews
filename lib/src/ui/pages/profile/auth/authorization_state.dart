import 'package:firebase_auth/firebase_auth.dart';

class AuthorizationState {
  final bool isLoading;
  final User user;
  final FirebaseAuthException error;

  const AuthorizationState({this.isLoading = false, this.user, this.error});
}
