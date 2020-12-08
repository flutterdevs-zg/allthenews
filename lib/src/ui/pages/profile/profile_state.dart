import 'package:allthenews/src/domain/communication/firebase_exception.dart';
import 'package:allthenews/src/domain/model/user.dart';

class ProfileState {
  final bool isLoading;
  final User user;
  final AuthenticationException exception;

  const ProfileState({this.isLoading = false, this.user, this.exception});
}
