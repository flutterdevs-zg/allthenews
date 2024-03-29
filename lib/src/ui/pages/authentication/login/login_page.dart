import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/app/navigation/route_page_manager.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/common/widget/ny_times_appbar.dart';
import 'package:allthenews/src/ui/common/widget/primary_text_button.dart';
import 'package:allthenews/src/ui/pages/authentication/auth_text_field.dart';
import 'package:allthenews/src/ui/pages/authentication/message/authentication_error_message.dart';
import 'package:allthenews/src/ui/pages/authentication/login/login_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class _Constants {
  static const buttonVerticalPadding = 10.0;
  static const buttonHorizontalPadding = 20.0;
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AuthenticationErrorMessage {
  final LoginNotifier _loginNotifier = inject<LoginNotifier>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loginNotifier.returnToProfile = () => context.read<RoutePageManager>().pop();

    _emailTextController.addListener(() {
      _loginNotifier.updateEmail(_emailTextController.text);
    });
    _passwordTextController.addListener(() {
      _loginNotifier.updatePassword(_passwordTextController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: NyTimesAppBar(
        title: Strings.current.loginTitle,
        hasBackButton: true,
        backButtonAction: () => context.read<RoutePageManager>().pop(),
      ),
      body: ChangeNotifierProvider.value(
          value: _loginNotifier,
          builder: (context, child) {
            final state = context.select((LoginNotifier notifier) => notifier.state);

            return WillPopScope(
              onWillPop: () {
                context.read<RoutePageManager>().pop();
                return Future.value(true);
              },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthTextField(
                      textInputType: TextInputType.emailAddress,
                      errorText: state.emailError,
                      textController: _emailTextController,
                      labelText: Strings.current.email,
                    ),
                    AuthTextField(
                      errorText: state.passwordError,
                      textController: _passwordTextController,
                      labelText: Strings.current.password,
                      obscureText: true,
                    ),
                    buildAuthenticationErrorMessage(state.authenticationError),
                    PrimaryTextButton(
                      textPadding: const EdgeInsets.symmetric(
                        vertical: _Constants.buttonVerticalPadding,
                        horizontal: _Constants.buttonHorizontalPadding,
                      ),
                      text: Strings.current.login,
                      isLoading: state.isLoading,

                      onPressed: () {
                        context.read<LoginNotifier>().validateFieldsAndSignIn();
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }
}
