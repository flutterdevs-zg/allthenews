import 'package:allthenews/src/domain/location/location.dart';

abstract class LocationResolver {

  Future<bool> isLocationServiceEnabled();

  Future<bool> isPermissionDenied();

  Future<bool> isPermissionDeniedForever();

  Future<void> requestPermission();

  Future<Location> getCurrentLocation();

}