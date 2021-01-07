import 'package:allthenews/src/domain/location/location.dart';
import 'package:allthenews/src/domain/location/location_exception.dart';
import 'package:allthenews/src/domain/location/location_resolver.dart';
import 'package:allthenews/src/ui/pages/location/location_error_view_entity_mapper.dart';
import 'package:allthenews/src/ui/pages/location/location_view_state.dart';
import 'package:flutter/cupertino.dart';

class LocationNotifier extends ChangeNotifier {
  final LocationResolver _locationResolver;
  final LocationErrorViewEntityMapper _errorViewEntityMapper;

  LocationViewState _state = const LocationViewState();

  LocationNotifier(
    this._errorViewEntityMapper,
    this._locationResolver,
  );

  LocationViewState get state => _state;

  Future<void> findUserLocation() async {
    _setNotifierState(const LocationViewState(isLoading: true));
    try {
      final Location location = await _locationResolver.getCurrentLocation();
      _setNotifierState(LocationViewState(location: location));
    } on Exception catch (exception) {
      _setNotifierState(LocationViewState(error: _errorViewEntityMapper.map(exception)));
    }
  }

  Future<void> retry() async {
    try {
      _setNotifierState(const LocationViewState(isLoading: true));
      final Location location = await _locationResolver.getCurrentLocation();
      _setNotifierState(LocationViewState(location: location));
    } on LocationServiceDisabledException catch (_) {
      await _locationResolver.openLocationSettings();
    } on Exception catch (exception) {
      _setNotifierState(LocationViewState(error: _errorViewEntityMapper.map(exception)));
    }
  }

  void _setNotifierState(LocationViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
