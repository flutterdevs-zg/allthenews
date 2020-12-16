import 'package:allthenews/src/domain/authorization/authentication_repository.dart';
import 'package:allthenews/src/domain/communication/firebase_exception.dart';
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

  VoidCallback returnToProfile;

  void initUserState() {
    _setNotifierState(_state.copyWithLoading(isLoading: true));
    _authorizationRepository.observeUserChanges().listen((user) {
      _setNotifierState(_state.copyWithUserAndLoading(user: user, isLoading: false));
    });
  }

  Future<void> logout() async {
    try {
      await _authorizationRepository.logout();
      returnToProfile?.call();
    } on AuthenticationApiException catch (exception) {
      _setNotifierState(_state.copyWithLoadingAndAuthError(
        error: _authenticationMessageProvider.getMessage(exception),
        isLoading: false,
      ));
    }
  }

  void _setNotifierState(ProfileState authorizationState) {
    _state = authorizationState;
    notifyListeners();
  }
}
