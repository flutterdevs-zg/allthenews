import 'package:allthenews/src/domain/location/location.dart';

abstract class LocationProvider {

  Future<Location> getCurrentLocation();

}