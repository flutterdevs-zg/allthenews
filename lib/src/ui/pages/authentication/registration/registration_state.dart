import 'package:flutter/foundation.dart';

class RegistrationState {
  final String name;
  final String email;
  final String password;
  final bool isLoading;
  final String emailError;
  final String nameError;
  final String passwordError;
  final String authenticationError;

  const RegistrationState({
    this.email = "",
    this.name = "",
    this.password = "",
    this.isLoading = false,
    this.emailError,
    this.nameError,
    this.passwordError,
    this.authenticationError,
  });

  bool get canSubmit => [emailError, nameError, passwordError].every((element) => element == null);

  RegistrationState copyWithLoading({@required bool isLoading}) => RegistrationState(
        name: name,
        email: email,
        password: password,
        isLoading: isLoading,
        nameError: nameError,
        passwordError: passwordError,
        emailError: emailError,
        authenticationError: authenticationError,
      );

  RegistrationState copyWithLoadingAndAuthError({
    @required bool isLoading,
    @required String authenticationError,
  }) =>
      RegistrationState(
        name: name,
        email: email,
        password: password,
        isLoading: isLoading,
        nameError: nameError,
        passwordError: passwordError,
        emailError: emailError,
        authenticationError: authenticationError,
      );

  RegistrationState copyWithFieldsError({
    @required String emailError,
    @required String nameError,
    @required String passwordError,
  }) =>
      RegistrationState(
        name: name,
        email: email,
        password: password,
        isLoading: isLoading,
        nameError: nameError,
        passwordError: passwordError,
        emailError: emailError,
        authenticationError: authenticationError,
      );

  RegistrationState copyWithNameAndClearError({@required String name}) => RegistrationState(
        name: name,
        email: email,
        password: password,
        isLoading: isLoading,
        passwordError: passwordError,
        emailError: emailError,
      );

  RegistrationState copyWithEmailAndClearError({@required String email}) => RegistrationState(
        name: name,
        email: email,
        password: password,
        isLoading: isLoading,
        nameError: nameError,
        passwordError: passwordError,
      );

  RegistrationState copyWithPasswordAndClearError({@required String password}) => RegistrationState(
        name: name,
        email: email,
        password: password,
        isLoading: isLoading,
        nameError: nameError,
        emailError: emailError,
      );
}
