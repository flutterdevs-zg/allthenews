import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/domain/location/location.dart';
import 'package:flutter/material.dart';

class _Constants {
  static const widthScreenRatio = 0.70;
  static const height = 80.0;
  static const padding = 20.0;
  static const radius = 50.0;
}

class LocationInfoLabel extends StatelessWidget {
  final Location location;

  const LocationInfoLabel({
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(_Constants.padding),
        height: _Constants.height,
        width: MediaQuery.of(context).size.width * _Constants.widthScreenRatio,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(_Constants.radius)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(Strings.current.yourLocation, style: Theme.of(context).textTheme.bodyText2),
            Text('${Strings.current.latitude}: ${location.latitude.toString()}',
                style: Theme.of(context).textTheme.bodyText2),
            Text('${Strings.current.longitude}: ${location.longitude.toString()}',
                style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
      ),
    );
  }
}
