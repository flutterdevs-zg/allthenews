import 'package:allthenews/src/domain/location/location.dart';

abstract class LocationResolver {

  Future<Location> getCurrentLocation();

  Future<void> openLocationSettings();

}