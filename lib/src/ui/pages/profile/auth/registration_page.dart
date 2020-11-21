import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/common/mixin/error_mixin.dart';
import 'package:allthenews/src/ui/common/widget/ny_times_appbar.dart';
import 'package:allthenews/src/ui/pages/home/home_page.dart';
import 'package:allthenews/src/ui/pages/profile/auth/auth_text_form_field.dart';
import 'package:allthenews/src/ui/pages/profile/auth/authorization_notifier.dart';
import 'package:allthenews/src/ui/pages/profile/auth/authorization_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class _Constants {
  static const spaceBetweenFields = 15.0;
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> with ErrorMessage {
  final AuthorizationNotifier _authorizationNotifier = inject<AuthorizationNotifier>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _authorizationNotifier.returnToProfile = () => _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: NyTimesAppBar(
        title: Strings.of(context).registrationTitle,
        hasBackButton: true,
        backButtonAction: () => _navigateToHome(),
      ),
      body: ChangeNotifierProvider.value(
        value: _authorizationNotifier,
        builder: (providerContext, child) {
          final state = providerContext.select((AuthorizationNotifier notifier) => notifier.state);

          return WillPopScope(
            onWillPop: () {
              _navigateToHome();
              return Future.value(true);
            },
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: _buildFieldsColumn(providerContext, state),
              ),
            ),
          );
        },
      ),
    );
  }

  Column _buildFieldsColumn(BuildContext providerContext, AuthorizationState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AuthTextFormField(
          textController: _nameController,
          hint: Strings.of(context).name,
        ),
        const SizedBox(height: _Constants.spaceBetweenFields),
        AuthTextFormField(
          textController: _emailTextController,
          hint: Strings.of(context).email,
        ),
        const SizedBox(height: _Constants.spaceBetweenFields),
        AuthTextFormField(
          textController: _passwordTextController,
          hint: Strings.of(context).password,
          obscureText: true,
        ),
        const SizedBox(height: _Constants.spaceBetweenFields),
        buildErrorMessage(state.error),
        const SizedBox(height: _Constants.spaceBetweenFields),
        FlatButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              providerContext.read<AuthorizationNotifier>().createUser(
                    _emailTextController.text,
                    _passwordTextController.text,
                    _nameController.text,
                  );
            }
          },
          child: Text(Strings.of(context).createAccount),
        ),
      ],
    );
  }

  void _navigateToHome() => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(initialPage: 1),
      ));

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
