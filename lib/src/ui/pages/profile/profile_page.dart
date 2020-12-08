import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/common/widget/primary_text_button.dart';
import 'package:allthenews/src/ui/pages/authentication/authentication_page.dart';
import 'package:allthenews/src/ui/pages/profile/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class _Constants {
  static const buttonVerticalPadding = 30.0;
  static const buttonHorizontalPadding = 30.0;
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileNotifier _authorizationNotifier = inject<ProfileNotifier>();

  @override
  void initState() {
    super.initState();
    _authorizationNotifier.initUserState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: _authorizationNotifier,
        builder: (providerContext, child) {
          final viewState = providerContext.select((ProfileNotifier notifier) => notifier.state);

          if (viewState.user == null) {
            return AuthenticationPage();
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(_authorizationNotifier.state.user.email),
                  Text(_authorizationNotifier.state.user.name),
                  PrimaryTextButton(
                    textPadding: const EdgeInsets.symmetric(
                      vertical: _Constants.buttonVerticalPadding,
                      horizontal: _Constants.buttonHorizontalPadding,
                    ),
                    onPressed: () => _authorizationNotifier.logout(),
                    text: Strings.current.logout,
                  ),
                ],
              ),
            );
          }
        });
  }
}
