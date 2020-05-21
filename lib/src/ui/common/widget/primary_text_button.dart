import 'package:allthenews/src/ui/common/widget/primary_button.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const paddingHorizontal = 10.0;
  static const paddingVertical = 5.0;
}

class PrimaryTextButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const PrimaryTextButton({
    @required this.text,
    @required this.onPressed,
  })  : assert(onPressed != null),
        assert(text != null);

  @override
  Widget build(BuildContext context) => PrimaryButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: _Constants.paddingHorizontal,
            vertical: _Constants.paddingVertical,
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.button,
          ),
        ),
      );
}
