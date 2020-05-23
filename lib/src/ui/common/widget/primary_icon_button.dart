import 'package:allthenews/src/ui/common/widget/primary_button.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const iconPadding = 8.0;
  static const iconSize = 16.0;
}

class PrimaryIconButton extends StatelessWidget {
  final IconData iconData;
  final Function onPressed;

  const PrimaryIconButton({
    @required this.iconData,
    @required this.onPressed,
  })  : assert(onPressed != null),
        assert(iconData != null);

  @override
  Widget build(BuildContext context) => PrimaryButton(
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.all(_Constants.iconPadding),
          child: Icon(
            iconData,
            size: _Constants.iconSize,
          ),
        ),
      );
}
