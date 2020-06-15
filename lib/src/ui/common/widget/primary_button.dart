import 'package:flutter/material.dart';

abstract class _Constants {
  static const radius = 8.0;
  static const elevation = 0.0;
}

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  const PrimaryButton({
    @required this.child,
    @required this.onPressed,
  })  : assert(onPressed != null),
        assert(child != null);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      constraints: BoxConstraints(),
      child: child,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      fillColor: Theme.of(context).buttonColor,
      highlightElevation: _Constants.elevation,
      elevation: _Constants.elevation,
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          _Constants.radius,
        ),
      ),
    );
  }
}
