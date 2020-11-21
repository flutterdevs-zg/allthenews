import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/pages/profile/auth/authentication_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/authorization_notifier.dart';

abstract class _Constants {
  static const fontFamily = 'Chomsky';
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthorizationNotifier _authorizationNotifier = inject<AuthorizationNotifier>();

  @override
  void initState() {
    super.initState();
    _authorizationNotifier.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: _authorizationNotifier,
        builder: (providerContext, child) {
          final viewState =
              providerContext.select((AuthorizationNotifier notifier) => notifier.state);

          if (viewState.user == null) {
            return AuthenticationPage();
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(_authorizationNotifier.state.user?.email),
                  Text(_authorizationNotifier.state.user?.displayName),
                  Text("User uid: ${_authorizationNotifier.state.user?.uid}"),
                  FlatButton(
                    onPressed: () => _authorizationNotifier.logout(),
                    child: Text(
                      Strings.of(context).logout,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontFamily: _Constants.fontFamily),
                    ),
                  )
                ],
              ),
            );
          }
        });
  }
}
