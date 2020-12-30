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

  RegistrationState copyWithLoadingAndAuthError({
    bool isLoading,
    String authenticationError,
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
    String emailError,
    String nameError,
    String passwordError,
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

  RegistrationState copyWithNameAndClearError({
    String name,
    String authenticationError,
    String nameError,
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

  RegistrationState copyWithEmailAndClearError({
    String email,
    String authenticationError,
    String emailError,
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

  RegistrationState copyWithPasswordAndClearError({
    String password,
    String authenticationError,
    String passwordError,
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
}
