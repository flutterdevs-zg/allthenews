import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/authorization/authentication_repository.dart';
import 'package:allthenews/src/domain/communication/exception_mapper.dart';
import 'package:allthenews/src/ui/pages/authentication/registration/registration_state.dart';
import 'package:flutter/cupertino.dart';

class RegistrationNotifier extends ChangeNotifier {
  final AuthenticationRepository _authorizationRepository;
  final ExceptionMapper _exceptionMapper;

  RegistrationNotifier(this._authorizationRepository, this._exceptionMapper);

  RegistrationState _state = const RegistrationState();

  RegistrationState get state => _state;

  VoidCallback returnToProfile;

  Future<void> createUser(String email, String password, String name) async {
    _validateFields();

    if (!_state.canSubmit) {
      notifyListeners();
      return;
    }

    _setNotifierState(_state.copyWith(isLoading: true));

    try {
      await _authorizationRepository.createUser(email, password);
      _updateUserName(name);
    } on Exception catch (exception) {
      _setNotifierState(_state.copyWith(
        exception: _exceptionMapper.toDomainException(exception),
        isLoading: false,
      ));
    }
  }

  Future<void> _updateUserName(String name) async {
    try {
      await _authorizationRepository.updateUser(name);
      _setNotifierState(_state.copyWith(isLoading: false));
      returnToProfile?.call();
    } on Exception catch (exception) {
      _setNotifierState(_state.copyWith(
        exception: _exceptionMapper.toDomainException(exception),
        isLoading: false,
      ));
    }
  }

  void _validateFields() {
    String emailError;
    String nameError;
    String passwordError;

    if (_state.email.isEmpty) {
      emailError = Strings.current.emptyFieldError;
    }

    if (_state.name.isEmpty) {
      nameError = Strings.current.emptyFieldError;
    }

    if (_state.password.isEmpty) {
      passwordError = Strings.current.emptyFieldError;
    }

    _state = _state.copyWith(
      emailError: emailError,
      passwordError: passwordError,
      nameError: nameError,
    );
  }

  void _setNotifierState(RegistrationState registrationState) {
    _state = registrationState;
    notifyListeners();
  }

  void setEmail(String email) {
    _setNotifierState(_state.copyWith(email: email));
  }

  void setName(String name) {
    _setNotifierState(_state.copyWith(name: name));
  }

  void setPassword(String password) {
    _setNotifierState(_state.copyWith(password: password));
  }
}
