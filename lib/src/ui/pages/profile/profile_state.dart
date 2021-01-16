import 'package:allthenews/src/domain/model/user.dart';

class ProfileState {
  final bool isLoading;
  final User user;
  final String error;

  const ProfileState({
    this.isLoading = false,
    this.user,
    this.error,
  });
}
