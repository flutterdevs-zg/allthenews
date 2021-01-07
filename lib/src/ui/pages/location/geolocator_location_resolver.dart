import 'package:allthenews/src/domain/location/location.dart';
import 'package:allthenews/src/domain/location/location_resolver.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorLocationResolver implements LocationResolver {
  @override
  Future<bool> isLocationServiceEnabled() => Geolocator.isLocationServiceEnabled();

  @override
  Future<bool> isPermissionDenied() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever;
  }

  @override
  Future<bool> isPermissionDeniedForever() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever;
  }

  @override
  Future<void> requestPermission() => Geolocator.requestPermission();

  @override
  Future<Location> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    return Location(latitude: position.latitude, longitude: position.longitude);
  }
}