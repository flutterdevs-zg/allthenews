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

  LoginState copyWithLoading({bool isLoading}) => LoginState(
        isLoading: isLoading,
        authenticationError: authenticationError,
        email: email,
        emailError: emailError,
        password: password,
        passwordError: passwordError,
      );

  LoginState copyWithLoadingAndAuthError({bool isLoading, String authenticationError}) => LoginState(
        isLoading: isLoading,
        authenticationError: authenticationError,
        email: email,
        emailError: emailError,
        password: password,
        passwordError: passwordError,
      );

  LoginState copyWithEmailAndClearErrors({String email}) => LoginState(
        isLoading: isLoading,
        email: email,
        password: password,
      );

  LoginState copyWithPasswordAndClearErrors({String password}) => LoginState(
        isLoading: isLoading,
        email: email,
        password: password,
      );

  LoginState copyWithFieldsErrors({
    String emailError,
    String passwordError,
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
