import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/authorization/authentication_repository.dart';
import 'package:allthenews/src/domain/communication/exception_mapper.dart';
import 'package:allthenews/src/ui/pages/authentication/login/login_state.dart';
import 'package:flutter/cupertino.dart';

class LoginNotifier extends ChangeNotifier {
  final AuthenticationRepository _authorizationRepository;
  final ExceptionMapper _exceptionMapper;

  LoginNotifier(this._authorizationRepository, this._exceptionMapper);

  LoginState _state = const LoginState();

  LoginState get state => _state;

  VoidCallback returnToProfile;

  Future<void> signIn(String email, String password) async {
    _validateFields();

    if (!_state.canSubmit) {
      notifyListeners();
      return;
    }

    _setNotifierState(_state.copyWith(isLoading: true));

    try {
      await _authorizationRepository.signIn(email, password);
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
    String passwordError;

    if (_state.email.isEmpty) {
      emailError = Strings.current.emptyFieldError;
    }

    if (_state.password.isEmpty) {
      passwordError = Strings.current.emptyFieldError;
    }

    _state = _state.copyWith(
      emailError: emailError,
      passwordError: passwordError,
    );
  }

  Future<void> _setNotifierState(LoginState loginState) async {
    _state = loginState;
    notifyListeners();
  }

  void setEmail(String email) {
    _setNotifierState(_state.copyWith(email: email));
  }

  void setPassword(String password) {
    _setNotifierState(_state.copyWith(password: password));
  }
}
