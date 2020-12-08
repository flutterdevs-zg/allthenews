import 'package:allthenews/src/domain/communication/all_the_news_exception.dart';

class LoginState {
  final bool isLoading;
  final AllTheNewsException exception;
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
    this.exception,
  });

  LoginState copyWith({
    bool isLoading,
    AllTheNewsException exception,
    String email,
    String emailError,
    String passwordError,
    String password,
  }) =>
      LoginState(
        isLoading: isLoading ?? this.isLoading,
        exception: exception,
        email: email ?? this.email,
        emailError: emailError,
        password: password ?? this.password,
        passwordError: passwordError,
      );
}
