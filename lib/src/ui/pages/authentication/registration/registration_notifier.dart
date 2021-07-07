import 'package:allthenews/src/domain/authentication/authentication_api_exception.dart';
import 'package:allthenews/src/domain/authentication/authentication_repository.dart';
import 'package:allthenews/src/domain/common/error/field_error.dart';
import 'package:allthenews/src/ui/common/message_provider.dart';
import 'package:allthenews/src/ui/pages/authentication/registration/registration_state.dart';
import 'package:flutter/cupertino.dart';

class RegistrationNotifier extends ChangeNotifier {
  final AuthenticationRepository _authenticationRepository;
  final MessageProvider _authenticationMessageProvider;
  final MessageProvider _fieldErrorMessageProvider;

  RegistrationNotifier(
    this._authenticationRepository,
    this._authenticationMessageProvider,
    this._fieldErrorMessageProvider,
  );

  RegistrationState _state = const RegistrationState();

  RegistrationState get state => _state;

  String get emptyFieldError => _fieldErrorMessageProvider.getMessage(FieldError.isEmpty);

  VoidCallback? returnToProfile;

  void validateFieldsAndCreateUser() {
    _validateFields(
      onInvalid: () => notifyListeners(),
      onValid: () => _createUser(),
    );
  }

  Future<void> _createUser() async {
    _setNotifierState(_state.copyWithLoading(isLoading: true));
    try {
      await _authenticationRepository.createUser(_state.email, _state.password);
      _updateUserName(_state.name);
    } on AuthenticationApiException catch (exception) {
      _setNotifierState(
        _state.copyWithLoadingAndAuthError(
            authenticationError: _authenticationMessageProvider.getMessage(exception),
            isLoading: false),
      );
    }
  }

  Future<void> _updateUserName(String name) async {
    try {
      await _authenticationRepository.updateUser(name);
      _setNotifierState(const RegistrationState());
      returnToProfile?.call();
    } on AuthenticationApiException catch (exception) {
      _setNotifierState(
        _state.copyWithLoadingAndAuthError(
            authenticationError: _authenticationMessageProvider.getMessage(exception),
            isLoading: false),
      );
    }
  }

  void _validateFields({required VoidCallback onValid, required VoidCallback onInvalid}) {
    _state = _state.copyWithFieldsError(
      emailError: _state.email.isEmpty ? emptyFieldError : null,
      nameError: _state.name.isEmpty ? emptyFieldError : null,
      passwordError: _state.password.isEmpty ? emptyFieldError : null,
    );

    _state.canSubmit ? onValid() : onInvalid();
  }

  void _setNotifierState(RegistrationState registrationState) {
    _state = registrationState;
    notifyListeners();
  }

  void updateEmail(String email) {
    _setNotifierState(_state.copyWithEmailAndClearError(email: email));
  }

  void updateName(String name) {
    _setNotifierState(_state.copyWithNameAndClearError(name: name));
  }

  void updatePassword(String password) {
    _setNotifierState(_state.copyWithPasswordAndClearError(password: password));
  }
}
