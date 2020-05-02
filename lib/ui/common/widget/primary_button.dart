import 'package:flutter/material.dart';

abstract class _Constants {
  static const radius = 8.0;
  static const elevation = 0.0;
  static const backgroundColor = Color(0xFFE0E0E0);
  static const paddingHorizontal = 10.0;
  static const paddingVertical = 5.0;
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const PrimaryButton({
    @required this.text,
    @required this.onPressed,
  }) : assert(onPressed != null);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      constraints: BoxConstraints(),
      child: Text(
        text,
        style: Theme.of(context).textTheme.button,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: _Constants.paddingHorizontal,
        vertical: _Constants.paddingVertical,
      ),
      fillColor: _Constants.backgroundColor,
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
