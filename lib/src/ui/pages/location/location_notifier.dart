import 'package:allthenews/src/domain/location/get_location_use_case.dart';
import 'package:allthenews/src/domain/location/location.dart';
import 'package:allthenews/src/domain/location/location_exception.dart';
import 'package:allthenews/src/domain/location/location_resolver.dart';
import 'package:allthenews/src/ui/pages/location/location_error_view_entity_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationNotifier extends ChangeNotifier {
  final GetLocationUseCase _getLocationUseCase;
  final LocationResolver _locationResolver;
  final LocationErrorViewEntityMapper _errorViewEntityMapper;

  LocationViewState _state = const LocationViewState();

  LocationNotifier(this._getLocationUseCase, this._errorViewEntityMapper, this._locationResolver);

  LocationViewState get state => _state;

  Future<void> findUserLocation() async {
    _setNotifierState(const LocationViewState(isLoading: true));
    await _getLocationUseCase()
        .then((location) => _setNotifierState(LocationViewState(location: location)))
        .catchError((exception) => _setNotifierState(
            LocationViewState(error: _errorViewEntityMapper.map(exception as LocationException))));
  }

  Future<void> retry() async {
    if (await _locationResolver.isLocationServiceEnabled()) {
      findUserLocation();
    } else {
      final locationSettingsOpened = await Geolocator.openLocationSettings();
      if (!locationSettingsOpened) {
        findUserLocation();
      }
    }
  }

  void _setNotifierState(LocationViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}

class LocationViewState {
  final bool isLoading;
  final Location location;
  final LocationErrorViewEntity error;

  const LocationViewState({this.isLoading = false, this.location, this.error});
}

class LocationErrorViewEntity {
  final String errorMessage;
  final bool shouldShowRetryButton;

  LocationErrorViewEntity({this.errorMessage = '', this.shouldShowRetryButton = false});
}
