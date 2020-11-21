import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/common/mixin/error_mixin.dart';
import 'package:allthenews/src/ui/common/widget/ny_times_appbar.dart';
import 'package:allthenews/src/ui/pages/home/home_page.dart';
import 'package:allthenews/src/ui/pages/profile/auth/auth_text_form_field.dart';
import 'package:allthenews/src/ui/pages/profile/auth/authorization_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class _Constants {
  static const fontFamily = 'Chomsky';
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ErrorMessage {
  final AuthorizationNotifier _authorizationNotifier = inject<AuthorizationNotifier>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _authorizationNotifier.returnToProfile = () => _navigateToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: NyTimesAppBar(
        title: Strings.of(context).loginTitle,
        hasBackButton: true,
        backButtonAction: () => _navigateToHome(context),
      ),
      body: ChangeNotifierProvider.value(
          value: _authorizationNotifier,
          builder: (context, child) {
            final state = context.select((AuthorizationNotifier notifier) => notifier.state);

            return WillPopScope(
              onWillPop: () {
                _navigateToHome(context);
                return Future.value(true);
              },
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthTextFormField(
                        textController: _emailTextController,
                        hint: Strings.of(context).email,
                      ),
                      AuthTextFormField(
                        textController: _passwordTextController,
                        hint: Strings.of(context).password,
                        obscureText: true,
                      ),
                      buildErrorMessage(state.error),
                      FlatButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            context
                                .read<AuthorizationNotifier>()
                                .signIn(_emailTextController.text, _passwordTextController.text);
                          }
                        },
                        child: Text(
                          Strings.of(context).login,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontFamily: _Constants.fontFamily),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future _navigateToHome(BuildContext context) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(initialPage: 1),
      ));

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }
}
