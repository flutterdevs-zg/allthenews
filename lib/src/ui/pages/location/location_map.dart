import 'dart:async';

import 'package:allthenews/src/domain/location/location.dart';
import 'package:allthenews/src/ui/pages/location/location_info_pin.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class _Constants {
  static const mapZoom = 12.0;
  static const markerId = 'markerId';
  static const pinLeftPosition = 0.0;
  static const pinRightPosition = 0.0;
  static const pinBottomPosition = 0.0;
}

class LocationMap extends StatefulWidget {
  final Location location;

  const LocationMap({Key key, this.location}) : super(key: key);

  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.location.latitude,
              widget.location.longitude,
            ),
            zoom: _Constants.mapZoom,
          ),
          myLocationButtonEnabled: false,
          markers: {_toMarker(context, widget.location)},
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        LocationInfoPin(
          leftPosition: _Constants.pinLeftPosition,
          rightPosition: _Constants.pinRightPosition,
          bottomPosition: _Constants.pinBottomPosition,
          location: widget.location,
        ),
      ],
    );
  }

  Marker _toMarker(BuildContext context, Location location) {
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
