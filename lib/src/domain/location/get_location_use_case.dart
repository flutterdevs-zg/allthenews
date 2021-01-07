import 'package:allthenews/src/domain/location/location.dart';
import 'package:allthenews/src/domain/location/location_exception.dart';
import 'package:allthenews/src/domain/location/location_resolver.dart';

class GetLocationUseCase {
  final LocationResolver _locationResolver;

  GetLocationUseCase(this._locationResolver);

  Future<Location> call() async {
    final isServiceEnabled = await _locationResolver.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error(LocationServiceDisabledException());
    }

    if (await _locationResolver.isPermissionDeniedForever()) {
      return Future.error(PermissionDeniedForeverException());
    }

    if (await _locationResolver.isPermissionDenied()) {
      await _locationResolver.requestPermission();
    }

    if (await _locationResolver.isPermissionDeniedForever()) {
      return Future.error(PermissionDeniedForeverException());
    }
    if (await _locationResolver.isPermissionDenied()) {
      return Future.error(PermissionDeniedException());
    }

    return _locationResolver.getCurrentLocation();
  }
}
