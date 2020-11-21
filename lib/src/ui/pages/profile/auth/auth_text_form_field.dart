import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/pages/profile/auth/authorization_notifier.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const fontFamily = 'Chomsky';
  static const widgetPadding = 15.0;
  static const borderRadius = 5.0;
  static const focusedBorderSideWidth = 3.0;
}

class AuthTextFormField extends StatelessWidget {
  final AuthorizationNotifier _authorizationNotifier = inject<AuthorizationNotifier>();
  final TextEditingController textController;
  final String hint;
  final bool obscureText;

  AuthTextFormField({
    this.textController,
    this.hint,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(_Constants.widgetPadding),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: textController,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: hint,
          labelStyle:
              Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: _Constants.fontFamily),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_Constants.borderRadius),
          ),
          hintStyle:
              Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: _Constants.fontFamily),
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_Constants.borderRadius),
            borderSide: BorderSide(
              width: _Constants.focusedBorderSideWidth,
              color: Theme.of(context).indicatorColor,
            ),
          ),
        ),
        cursorColor: Colors.black,
        style: Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: _Constants.fontFamily),
        validator: _authorizationNotifier.checkIfEmpty,
      ),
    );
  }
}
