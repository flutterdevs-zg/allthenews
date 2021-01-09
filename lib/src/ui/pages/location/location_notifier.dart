import 'package:allthenews/src/domain/location/location.dart';
import 'package:allthenews/src/domain/location/location_provider.dart';
import 'package:allthenews/src/ui/pages/location/location_error_view_entity_mapper.dart';
import 'package:allthenews/src/ui/pages/location/location_view_state.dart';
import 'package:flutter/cupertino.dart';

class LocationNotifier extends ChangeNotifier {
  final LocationProvider _locationProvider;
  final LocationErrorViewEntityMapper _errorViewEntityMapper;

  LocationViewState _state = const LocationViewState();

  LocationNotifier(
    this._errorViewEntityMapper,
    this._locationProvider,
  );

  LocationViewState get state => _state;

  Future<void> findUserLocation() async {
    _setNotifierState(const LocationViewState(isLoading: true));
    try {
      final Location location = await _locationProvider.getCurrentLocation();
      _setNotifierState(LocationViewState(location: location));
    } on Exception catch (exception) {
      _setNotifierState(LocationViewState(error: _errorViewEntityMapper.map(exception)));
    }
  }

  void _setNotifierState(LocationViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
