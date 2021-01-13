import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/common/widget/primary_text_button.dart';
import 'package:allthenews/src/ui/common/widget/retry_action_container.dart';
import 'package:allthenews/src/ui/pages/authentication/authentication_page.dart';
import 'package:allthenews/src/ui/pages/location/location_page.dart';
import 'package:allthenews/src/ui/pages/profile/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class _Constants {
  static const buttonVerticalPadding = 10.0;
  static const buttonHorizontalPadding = 20.0;
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileNotifier _profileNotifier = inject<ProfileNotifier>();

  @override
  void initState() {
    super.initState();
    _profileNotifier.initUserState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: _profileNotifier,
        builder: (providerContext, child) {
          final viewState = providerContext.select((ProfileNotifier notifier) => notifier.state);

          if (viewState.isLoading) {
            return _bindLoading();
          } else if (viewState.error != null) {
            return _buildErrorContent(providerContext);
          } else {
            if (viewState.user == null) {
              return _bindAuthentication();
            } else {
              return _bindUser();
            }
          }
        });
  }

  Widget _bindLoading() => const Center(child: CircularProgressIndicator());

  Widget _bindAuthentication() => AuthenticationPage();

  Widget _bindUser() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(_profileNotifier.state.user.email),
          Text(_profileNotifier.state.user.name),
          TextButton.icon(
            icon: const Icon(Icons.map),
            label: Text(Strings.current.location),
            onPressed: _navigateToLocationScreen,
          ),
          PrimaryTextButton(
            textPadding: const EdgeInsets.symmetric(
              vertical: _Constants.buttonVerticalPadding,
              horizontal: _Constants.buttonHorizontalPadding,
            ),
            onPressed: () => _profileNotifier.logout(),
            text: Strings.current.logout,
          ),
        ],
      ),
    );
  }

  void _navigateToLocationScreen() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationPage(),
        ),
      );

  Widget _buildErrorContent(BuildContext providerContext) =>
      RetryActionContainer(onRetryPressed: () => _profileNotifier.initUserState());
}
