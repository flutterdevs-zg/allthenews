import 'package:allthenews/src/domain/location/location.dart';
import 'package:allthenews/src/domain/location/location_resolver.dart';
import 'package:allthenews/src/domain/location/location_exception.dart' as domain;
import 'package:geolocator/geolocator.dart';

class GeolocatorLocationResolver implements LocationResolver {
  @override
  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();

  @override
  Future<Location> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      return Location(latitude: position.latitude, longitude: position.longitude);
    } on Exception catch (exception) {
      return Future.error(await _mapToDomainException(exception));
    }
  }

  Future<Exception> _mapToDomainException(Exception exception) async {
    if (exception is PermissionDeniedException) {
      return (await _isPermissionDeniedForever())
          ? domain.PermissionDeniedForeverException()
          : domain.PermissionDeniedException();
    } else if (exception is LocationServiceDisabledException) {
      return domain.LocationServiceDisabledException();
    } else {
      return domain.UnknownException();
    }
  }

  Future<bool> _isPermissionDeniedForever() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.deniedForever;
  }
}
