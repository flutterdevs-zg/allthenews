import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextStyleProvider {
  final BuildContext buildContext;

  TextStyleProvider({this.buildContext});

  TextStyle provideTitleTextStyle() =>
      Theme.of(buildContext).textTheme.subtitle1.copyWith(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            height: 1.5,
          );

  TextStyle provideSubtitleTextStyle() {
    final textTheme = Theme.of(buildContext).textTheme;

    return textTheme.bodyText2.copyWith(
      color: textTheme.caption.color,
      fontSize: 13,
    );
  }
}

