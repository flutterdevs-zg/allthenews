import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/ui/common/widget/primary_text_button.dart';
import 'package:allthenews/src/ui/pages/authentication/login/login_page.dart';
import 'package:allthenews/src/ui/pages/authentication/registration/registration_page.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const loginRegistrationSpace = 30.0;
  static const buttonVerticalPadding = 30.0;
  static const buttonHorizontalPadding = 30.0;
}

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryTextButton(
            textPadding: const EdgeInsets.symmetric(
              vertical: _Constants.buttonVerticalPadding,
              horizontal: _Constants.buttonHorizontalPadding,
            ),
            onPressed: () => _navigateTo(LoginPage()),
            text: Strings.current.login,
          ),
          const SizedBox(height: _Constants.loginRegistrationSpace),
          PrimaryTextButton(
            textPadding: const EdgeInsets.symmetric(
              vertical: _Constants.buttonVerticalPadding,
              horizontal: _Constants.buttonHorizontalPadding,
            ),
            onPressed: () => _navigateTo(RegistrationPage()),
            text: Strings.current.register,
          ),
        ],
      ),
    );
  }

  void _navigateTo(Widget page) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  }
}
