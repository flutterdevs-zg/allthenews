
import 'package:allthenews/src/domain/location/location.dart';
import 'package:allthenews/src/ui/pages/location/location_info_label.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class _Constants {
  static const mapZoom = 12.0;
  static const markerId = 'markerId';
}

class LocationMap extends StatelessWidget {
  final Location location;

  const LocationMap(this.location);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                location.latitude,
                location.longitude,
              ),
              zoom: _Constants.mapZoom,
            ),
            myLocationButtonEnabled: false,
            markers: {_toMarker(location)},
          ),
          LocationInfoLabel(
            location: location,
          ),
        ],
      ),
    );
  }

  Marker _toMarker(Location location) {
    return Marker(
      markerId: MarkerId(_Constants.markerId),
      position: LatLng(
        location.latitude,
        location.longitude,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
  }
}
