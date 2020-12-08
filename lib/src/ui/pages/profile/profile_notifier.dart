import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/authorization/authentication_repository.dart';
import 'package:allthenews/src/domain/communication/firebase_exception.dart';
import 'package:allthenews/src/ui/pages/profile/profile_state.dart';
import 'package:flutter/widgets.dart';

class ProfileNotifier extends ChangeNotifier {
  final AuthenticationRepository _authorizationRepository;

  ProfileState _state = const ProfileState();

  ProfileNotifier(this._authorizationRepository);

  ProfileState get state => _state;

  VoidCallback returnToProfile;

  void initUserState() {
    _authorizationRepository.observeUserChanges().listen((user) {
      _setNotifierState(ProfileState(user: user));
    });
  }

  void logout() {
    _authorizationRepository
        .logout()
        .then((_) => returnToProfile?.call())
        .catchError((exception) => _onUserAuthFailed(exception));
  }

  void _setNotifierState(ProfileState authorizationState) {
    _state = authorizationState;
    notifyListeners();
  }

  void _onUserAuthFailed(exception) {
    _setNotifierState(ProfileState(exception: exception as AuthenticationException));
  }

  String checkIfEmpty(String text) => text.isEmpty ? Strings.current.emptyFieldError : null;
}
