import 'package:allthenews/src/domain/model/user.dart';
import 'package:allthenews/src/ui/common/widget/retry_action_container.dart';
import 'package:allthenews/src/ui/pages/authentication/authentication_page.dart';
import 'package:allthenews/src/ui/pages/authentication/authentication_notifier.dart';
import 'package:allthenews/src/ui/pages/profile/user_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
          final viewState = context
              .select((AuthenticationNotifier notifier) => notifier.state);

          if (viewState.isLoading) {
            return _bindLoading();
          } else if (viewState.error != null) {
            return _buildErrorContent(context);
          } else {
            if (viewState.user == null) {
              return _bindAuthentication();
            } else {
              return _bindUser(viewState.user!);
            }
          }
  }

  Widget _bindLoading() => const Center(child: CircularProgressIndicator());

  Widget _bindAuthentication() => AuthenticationPage();

  Widget _bindUser(User user) => UserPage(user);

  Widget _buildErrorContent(BuildContext context) => RetryActionContainer(
      onRetryPressed: () => context.read<AuthenticationNotifier>().initUserState());
}
