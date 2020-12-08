import 'package:allthenews/src/domain/communication/all_the_news_exception.dart';

class RegistrationState {
  final String name;
  final String email;
  final String password;
  final bool isLoading;
  final AllTheNewsException exception;
  final String emailError;
  final String nameError;
  final String passwordError;

  const RegistrationState({
    this.email = "",
    this.name = "",
    this.password = "",
    this.emailError,
    this.nameError,
    this.passwordError,
    this.isLoading = false,
    this.exception,
  });

  bool get canSubmit => [emailError, nameError, passwordError].every((element) => element == null);

  RegistrationState copyWith({
    bool isLoading,
    AllTheNewsException exception,
    String email,
    String emailError,
    String nameError,
    String passwordError,
    String name,
    String password,
  }) =>
      RegistrationState(
        isLoading: isLoading ?? this.isLoading,
        name: name ?? this.name,
        nameError: nameError,
        exception: exception,
        email: email ?? this.email,
        emailError: emailError,
        password: password ?? this.password,
        passwordError: passwordError,
      );
}
