import 'package:allthenews/src/ui/common/widget/primary_button.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const paddingHorizontal = 10.0;
  static const paddingVertical = 5.0;
  static const progressIndicatorSize = 20.0;
}

class PrimaryTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry textPadding;
  final bool isLoading;

  const PrimaryTextButton({
    @required this.text,
    @required this.onPressed,
    this.textPadding = const EdgeInsets.symmetric(),
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) => PrimaryButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: _Constants.paddingHorizontal,
            vertical: _Constants.paddingVertical,
          ),
          child: Padding(
            padding: textPadding,
            child: isLoading
                ? const SizedBox(
                    width: _Constants.progressIndicatorSize,
                    height: _Constants.progressIndicatorSize,
                    child: CircularProgressIndicator(),
                  )
                : Text(
                    text,
                    style: Theme.of(context).textTheme.button.copyWith(
                          color: Colors.black,
                        ),
                  ),
          ),
        ),
      );
}
