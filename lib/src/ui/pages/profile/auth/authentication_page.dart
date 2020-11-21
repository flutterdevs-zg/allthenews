import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/ui/pages/profile/auth/registration_page.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

abstract class _Constants {
  static const fontFamily = 'Chomsky';
  static const loginRegistrationSpace = 30.0;
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
          FlatButton(
            onPressed: () => _navigateTo(LoginPage()),
            child: Text(
              Strings.of(context).login,
              style:
                  Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: _Constants.fontFamily),
            ),
          ),
          const SizedBox(height: _Constants.loginRegistrationSpace),
          FlatButton(
            onPressed: () => _navigateTo(RegistrationPage()),
            child: Text(
              Strings.of(context).register,
              style:
                  Theme.of(context).textTheme.bodyText1.copyWith(fontFamily: _Constants.fontFamily),
            ),
          ),
        ],
      ),
    );
  }

  Future _navigateTo(Widget page) {
    return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  }
}
