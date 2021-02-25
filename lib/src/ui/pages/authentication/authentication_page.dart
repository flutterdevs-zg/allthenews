import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/app/navigation/route_page_manager.dart';
import 'package:allthenews/src/ui/common/widget/primary_text_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class _Constants {
  static const loginRegistrationSpace = 30.0;
  static const buttonVerticalPadding = 10.0;
  static const buttonHorizontalPadding = 20.0;
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
            onPressed: () => context.read<RoutePageManager>().openLogin(),
            text: Strings.current.login,
          ),
          const SizedBox(height: _Constants.loginRegistrationSpace),
          PrimaryTextButton(
            textPadding: const EdgeInsets.symmetric(
              vertical: _Constants.buttonVerticalPadding,
              horizontal: _Constants.buttonHorizontalPadding,
            ),
            onPressed: () => context.read<RoutePageManager>().openRegistration(),
            text: Strings.current.register,
          ),
        ],
      ),
    );
  }
}
