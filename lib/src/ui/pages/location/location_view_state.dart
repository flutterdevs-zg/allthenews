import 'package:allthenews/src/domain/location/location.dart';

class LocationViewState {
  final bool isLoading;
  final Location location;
  final LocationErrorViewEntity error;

  const LocationViewState({
    this.isLoading = false,
    this.location,
    this.error,
  });
}

class LocationErrorViewEntity {
  final String errorMessage;
  final bool shouldShowRetryButton;

  const LocationErrorViewEntity({
    this.errorMessage = '',
    this.shouldShowRetryButton = false,
  });
}
