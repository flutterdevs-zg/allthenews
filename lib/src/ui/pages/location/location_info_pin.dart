import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/location/location.dart';
import 'package:flutter/material.dart';

class _Constants {
  static const widthScreenRatio = 0.70;
  static const height = 80.0;
  static const padding = 20.0;
  static const radius = 50.0;
}

class LocationInfoPin extends StatelessWidget {
  final double leftPosition;
  final double rightPosition;
  final double topPosition;
  final double bottomPosition;
  final Location location;

  const LocationInfoPin({
    this.leftPosition,
    this.rightPosition,
    this.topPosition,
    this.bottomPosition,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topPosition,
      right: rightPosition,
      bottom: bottomPosition,
      left: leftPosition,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.all(_Constants.padding),
          height: _Constants.height,
          width: MediaQuery.of(context).size.width * _Constants.widthScreenRatio,
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(_Constants.radius)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Strings.current.yourLocation,
                        style: Theme.of(context).textTheme.bodyText2),
                    Text('${Strings.current.latitude}: ${location.latitude.toString()}',
                        style: Theme.of(context).textTheme.bodyText2),
                    Text('${Strings.current.longitude}: ${location.longitude.toString()}',
                        style: Theme.of(context).textTheme.bodyText2),
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
