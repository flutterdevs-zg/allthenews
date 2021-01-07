import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/location/location.dart';
import 'package:flutter/material.dart';

class _Constants {
  static const widthScreenRatio = 0.70;
  static const height = 70.0;
  static const padding = 20.0;
  static const radius = 50.0;
  static const shadowOpacity = 0.5;
  static const shadowBlurRadius = 20.0;
  static const infoFontSize = 12.0;
}

class LocationInfoPin extends StatefulWidget {
  final double leftPosition;
  final double rightPosition;
  final double topPosition;
  final double bottomPosition;
  final Location location;

  const LocationInfoPin(
      {this.leftPosition,
      this.rightPosition,
      this.topPosition,
      this.bottomPosition,
      this.location});

  @override
  State<StatefulWidget> createState() => LocationInfoPinState();
}

class LocationInfoPinState extends State<LocationInfoPin> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.topPosition,
      right: widget.rightPosition,
      bottom: widget.bottomPosition,
      left: widget.leftPosition,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.all(_Constants.padding),
          height: _Constants.height,
          width: MediaQuery.of(context).size.width * _Constants.widthScreenRatio,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(_Constants.radius)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: _Constants.shadowBlurRadius,
                    color: Colors.grey.withOpacity(_Constants.shadowOpacity))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Strings.current.yourLocation, style: const TextStyle(color: Colors.blue)),
                    Text('${Strings.current.latitude}: ${widget.location.latitude.toString()}',
                        style:
                            const TextStyle(fontSize: _Constants.infoFontSize, color: Colors.grey)),
                    Text('${Strings.current.longitude}: ${widget.location.longitude.toString()}',
                        style:
                            const TextStyle(fontSize: _Constants.infoFontSize, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
