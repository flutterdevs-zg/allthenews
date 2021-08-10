import 'package:allthenews/src/domain/authentication/authentication_api_exception.dart';
import 'package:allthenews/src/domain/authentication/authentication_repository.dart';
import 'package:allthenews/src/ui/pages/authentication/message/authentication_message_provider.dart';
import 'package:allthenews/src/ui/pages/authentication/authentication_state.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationNotifier extends ChangeNotifier {
  final AuthenticationRepository _authorizationRepository;
  final AuthenticationMessageProvider _authenticationMessageProvider;
  AuthenticationState _state = const AuthenticationState();

  AuthenticationNotifier(
    this._authorizationRepository,
    this._authenticationMessageProvider,
  );

  AuthenticationState get state => _state;

  Future<void> initUserState() async {
    _setNotifierState(const AuthenticationState(isLoading: true));

    try {
      final userStream = await _authorizationRepository.observeUserChanges();
      userStream.listen((user) {
        _setNotifierState(AuthenticationState(user: user));
      });
    } on ConnectionException catch (exception) {
      _setNotifierState(
          AuthenticationState(error: _authenticationMessageProvider.getMessage(exception)));
    }
  }

  void _setNotifierState(AuthenticationState authorizationState) {
    _state = authorizationState;
    notifyListeners();
  }

  Future<void> logout() async {
    try {
      await _authorizationRepository.logout();
    } on AuthenticationApiException catch (exception) {
      _setNotifierState(
          AuthenticationState(error: _authenticationMessageProvider.getMessage(exception)));
    }
  }
}
