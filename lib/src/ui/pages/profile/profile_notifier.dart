import 'dart:async';

import 'package:allthenews/src/domain/authentication/authentication_repository.dart';
import 'package:allthenews/src/domain/authentication/authentication_api_exception.dart';
import 'package:allthenews/src/ui/pages/authentication/authentication_message_provider.dart';
import 'package:allthenews/src/ui/pages/profile/profile_state.dart';
import 'package:flutter/widgets.dart';

class ProfileNotifier extends ChangeNotifier {
  final AuthenticationRepository _authorizationRepository;
  final AuthenticationMessageProvider _authenticationMessageProvider;
  ProfileState _state = const ProfileState();

  ProfileNotifier(
    this._authorizationRepository,
    this._authenticationMessageProvider,
  );

  ProfileState get state => _state;

  Future<void> initUserState() async {
    _setNotifierState(const ProfileState(isLoading: true));

    try {
      final userStream = await _authorizationRepository.observeUserChanges();
      userStream.listen((user) {
        _setNotifierState(ProfileState(user: user));
      });
    } on ConnectionException catch (exception) {
      _setNotifierState(ProfileState(error: _authenticationMessageProvider.getMessage(exception)));
    }
  }

  Future<void> logout() async {
    try {
      await _authorizationRepository.logout();
    } on AuthenticationApiException catch (exception) {
      _setNotifierState(ProfileState(error: _authenticationMessageProvider.getMessage(exception)));
    }
  }

  void _setNotifierState(ProfileState authorizationState) {
    _state = authorizationState;
    notifyListeners();
  }
}
