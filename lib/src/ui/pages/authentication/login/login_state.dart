import 'package:flutter/foundation.dart';

class LoginState {
  final bool isLoading;
  final String authenticationError;
  final String email;
  final String emailError;
  final String password;
  final String passwordError;

  bool get canSubmit => [emailError, passwordError].every((element) => element == null);

  const LoginState({
    this.email = "",
    this.emailError,
    this.password = "",
    this.passwordError,
    this.isLoading = false,
    this.authenticationError,
  });

  LoginState copyWithLoading({@required bool isLoading}) => LoginState(
        isLoading: isLoading,
        authenticationError: authenticationError,
        email: email,
        emailError: emailError,
        password: password,
        passwordError: passwordError,
      );

  LoginState copyWithLoadingAndAuthError({
    @required bool isLoading,
    @required String authenticationError,
  }) =>
      LoginState(
        isLoading: isLoading,
        authenticationError: authenticationError,
        email: email,
        emailError: emailError,
        password: password,
        passwordError: passwordError,
      );

  LoginState copyWithEmailAndClearErrors({@required String email}) => LoginState(
        isLoading: isLoading,
        email: email,
        password: password,
      );

  LoginState copyWithPasswordAndClearErrors({@required String password}) => LoginState(
        isLoading: isLoading,
        email: email,
        password: password,
      );

  LoginState copyWithFieldsErrors({
    @required String emailError,
    @required String passwordError,
  }) =>
      LoginState(
        isLoading: isLoading,
        authenticationError: authenticationError,
        email: email,
        emailError: emailError,
        password: password,
        passwordError: passwordError,
      );
}
