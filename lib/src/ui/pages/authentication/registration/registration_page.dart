import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/app/navigation/route_page_manager.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/common/widget/ny_times_appbar.dart';
import 'package:allthenews/src/ui/common/widget/primary_text_button.dart';
import 'package:allthenews/src/ui/pages/authentication/auth_text_field.dart';
import 'package:allthenews/src/ui/pages/authentication/message/authentication_error_message.dart';
import 'package:allthenews/src/ui/pages/authentication/registration/registration_notifier.dart';
import 'package:allthenews/src/ui/pages/authentication/registration/registration_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class _Constants {
  static const spaceBetweenFields = 15.0;
  static const buttonVerticalPadding = 10.0;
  static const buttonHorizontalPadding = 20.0;
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> with AuthenticationErrorMessage {
  final RegistrationNotifier _registrationNotifier = inject<RegistrationNotifier>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _nameTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _registrationNotifier.returnToProfile = () => context.read<RoutePageManager>().pop();
    _emailTextController.addListener(() {
      _registrationNotifier.updateEmail(_emailTextController.text);
    });
    _nameTextController.addListener(() {
      _registrationNotifier.updateName(_nameTextController.text);
    });
    _passwordTextController.addListener(() {
      _registrationNotifier.updatePassword(_passwordTextController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: NyTimesAppBar(
        title: Strings.current.registrationTitle,
        hasBackButton: true,
        backButtonAction: () => context.read<RoutePageManager>().pop(),
      ),
      body: ChangeNotifierProvider.value(
        value: _registrationNotifier,
        builder: (providerContext, child) {
          final state = providerContext.select((RegistrationNotifier notifier) => notifier.state);

          return WillPopScope(
            onWillPop: () {
              context.read<RoutePageManager>().pop();
              return Future.value(true);
            },
            child: SingleChildScrollView(
              child: _buildFieldsColumn(providerContext, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFieldsColumn(BuildContext providerContext, RegistrationState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AuthTextField(
          errorText: state.nameError,
          textController: _nameTextController,
          labelText: Strings.current.name,
        ),
        const SizedBox(height: _Constants.spaceBetweenFields),
        AuthTextField(
          textInputType: TextInputType.emailAddress,
          errorText: state.emailError,
          textController: _emailTextController,
          labelText: Strings.current.email,
        ),
        const SizedBox(height: _Constants.spaceBetweenFields),
        AuthTextField(
          errorText: state.passwordError,
          textController: _passwordTextController,
          labelText: Strings.current.password,
          obscureText: true,
        ),
        const SizedBox(height: _Constants.spaceBetweenFields),
        buildAuthenticationErrorMessage(state.authenticationError),
        const SizedBox(height: _Constants.spaceBetweenFields),
        PrimaryTextButton(
          textPadding: const EdgeInsets.symmetric(
            vertical: _Constants.buttonVerticalPadding,
            horizontal: _Constants.buttonHorizontalPadding,
          ),
          isLoading: state.isLoading,
          onPressed: () {
            providerContext.read<RegistrationNotifier>().validateFieldsAndCreateUser();
          },
          text: Strings.current.createAccount,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _nameTextController.dispose();
    super.dispose();
  }
}
