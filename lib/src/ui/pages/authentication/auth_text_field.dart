import 'package:flutter/material.dart';

abstract class _Constants {
  static const widgetPadding = 15.0;
  static const borderRadius = 5.0;
  static const focusedBorderSideWidth = 3.0;
}

class AuthTextField extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final bool obscureText;
  final String errorText;
  final TextInputType textInputType;

  const AuthTextField({
    this.errorText,
    this.textController,
    this.labelText,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(_Constants.widgetPadding),
      child: TextField(
        controller: textController,
        obscureText: obscureText,
        keyboardType: textInputType,
        decoration: InputDecoration(
          errorText: errorText,
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_Constants.borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_Constants.borderRadius),
            borderSide: BorderSide(
              width: _Constants.focusedBorderSideWidth,
              color: Theme.of(context).indicatorColor,
            ),
          ),
        ),
        cursorColor: Colors.black,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
