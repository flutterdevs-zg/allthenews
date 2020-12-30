import 'package:allthenews/src/domain/common/error/field_error.dart';
import 'package:allthenews/src/domain/authentication/authentication_repository.dart';
import 'package:allthenews/src/domain/authentication/firebase_exception.dart';
import 'package:allthenews/src/ui/common/message_provider.dart';
import 'package:allthenews/src/ui/pages/authentication/login/login_state.dart';
import 'package:flutter/cupertino.dart';

class LoginNotifier extends ChangeNotifier {
  final AuthenticationRepository _authenticationRepository;
  final MessageProvider _authenticationMessageProvider;
  final MessageProvider _fieldErrorMessageProvider;

  LoginNotifier(
    this._authenticationRepository,
    this._authenticationMessageProvider,
    this._fieldErrorMessageProvider,
  );

  LoginState _state = const LoginState();

  LoginState get state => _state;

  String get emptyFieldError => _fieldErrorMessageProvider.getMessage(FieldError.isEmpty);

  VoidCallback returnToProfile;

  void validateFieldsAndSignIn() {
    _validateFields(
      onInvalid: () => notifyListeners(),
      onValid: () => _signIn(),
    );
  }

  Future<void> _signIn() async {
    _setNotifierState(_state.copyWithLoading(isLoading: true));

    try {
      await _authenticationRepository.signIn(_state.email, _state.password);
      _setNotifierState(_state.copyWithLoading(isLoading: false));
      returnToProfile?.call();
    } on AuthenticationApiException catch (exception) {
      _setNotifierState(_state.copyWithLoadingAndAuthError(
        authenticationError: _authenticationMessageProvider.getMessage(exception),
        isLoading: false,
      ));
    }
  }

  void _validateFields({@required VoidCallback onValid, @required VoidCallback onInvalid}) {
    _state = _state.copyWithFieldsErrors(
      emailError: _state.email.isEmpty ? emptyFieldError : null,
      passwordError: _state.password.isEmpty ? emptyFieldError : null,
    );

    _state.canSubmit ? onValid() : onInvalid();
  }

  void _setNotifierState(LoginState loginState) {
    _state = loginState;
    notifyListeners();
  }

  void updateEmail(String email) {
    _setNotifierState(_state.copyWithEmailAndClearErrors(email: email));
  }

  void updatePassword(String password) {
    _setNotifierState(_state.copyWithPasswordAndClearErrors(password: password));
  }
}
