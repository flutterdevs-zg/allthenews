import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/data/communication/firebase/firebase_authorization.dart';
import 'package:allthenews/src/domain/authorization/authorization.dart';
import 'package:allthenews/src/ui/pages/profile/auth/authorization_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthorizationNotifier extends ChangeNotifier {
  final Authorization authorization = FirebaseAuthorization();

  AuthorizationState _state = const AuthorizationState();

  AuthorizationState get state => _state;

  VoidCallback returnToProfile;

  void getCurrentUser() {
    authorization.userStream().listen((user) {
      _setNotifierState(AuthorizationState(user: user));
    });
  }

  void createUser(String email, String password, String name) {
    _setNotifierState(const AuthorizationState(isLoading: true));
    authorization
        .createUser(email, password)
        .then((userCredentials) => _updateUserName(userCredentials.user, name))
        .catchError((exception) => _onUserAuthFailed(exception));
  }

  void signIn(String email, String password) {
    _setNotifierState(const AuthorizationState(isLoading: true));
    authorization
        .signIn(email, password)
        .then((userCredentials) => returnToProfile.call())
        .catchError((exception) => _onUserAuthFailed(exception));
  }

  void _updateUserName(User user, String name) {
    authorization
        .updateUser(name)
        .then((_) => returnToProfile.call())
        .catchError((exception) => _onUserAuthFailed(exception));
  }

  void logout() {
    authorization
        .logout()
        .then((_) => returnToProfile?.call())
        .catchError((exception) => _onUserAuthFailed(exception));
  }

  void _setNotifierState(AuthorizationState authorizationState) {
    _state = authorizationState;
    notifyListeners();
  }

  void _onUserAuthFailed(exception) {
    _setNotifierState(AuthorizationState(error: exception as FirebaseAuthException));
  }

  String checkIfEmpty(String text) => text.isEmpty ? Strings.current.emptyFieldError : null;
}
