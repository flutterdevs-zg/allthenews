import 'package:flutter/material.dart';

abstract class _Constants {
  static const errorPadding = 16.0;
}

mixin AuthenticationErrorMessage {
  Widget buildAuthenticationErrorMessage(String? authenticationError) => authenticationError != null
      ? Padding(
          padding: const EdgeInsets.all(_Constants.errorPadding),
          child: Text(
            authenticationError,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        )
      : Container();
}
