import 'package:allthenews/src/domain/model/user.dart';
import 'package:flutter/foundation.dart';

class ProfileState {
  final bool isLoading;
  final User user;
  final String error;

  const ProfileState({
    this.isLoading = false,
    this.user,
    this.error,
  });

  ProfileState copyWithLoadingAndAuthError({@required bool isLoading, @required String error}) => ProfileState(
        isLoading: isLoading,
        user: user,
        error: error,
      );

  ProfileState copyWithLoading({@required bool isLoading}) => ProfileState(
        isLoading: isLoading,
        user: user,
        error: error,
      );

  ProfileState copyWithUserAndLoading({
    @required User user,
    @required bool isLoading,
  }) =>
      ProfileState(
        isLoading: isLoading,
        user: user,
        error: error,
      );

  ProfileState copyWithError({@required String error}) => ProfileState(
        isLoading: isLoading,
        user: user,
        error: error,
      );
}
