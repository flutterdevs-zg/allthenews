import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

mixin ErrorMessage {
  Widget buildErrorMessage(FirebaseAuthException error) => error != null
      ? Text(
          error.message,
          style: const TextStyle(color: Colors.red),
        )
      : Container();
}
