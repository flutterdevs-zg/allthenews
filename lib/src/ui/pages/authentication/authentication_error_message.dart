import 'package:allthenews/src/domain/communication/firebase_exception.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const errorPadding = 16.0;
}

mixin AuthenticationErrorMessage {
  Widget buildAuthenticationErrorMessage(AuthenticationException exception) => exception != null
      ? Padding(
          padding: const EdgeInsets.all(_Constants.errorPadding),
          child: Text(
            exception.message,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        )
      : Container();
}
