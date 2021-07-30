import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/app/navigation/route_page_manager.dart';
import 'package:allthenews/src/domain/model/user.dart';
import 'package:allthenews/src/ui/common/widget/primary_text_button.dart';
import 'package:allthenews/src/ui/pages/authentication/authentication_notifier.dart';
import 'package:allthenews/src/ui/pages/profile/user_section_item.dart';
import 'package:allthenews/src/ui/pages/profile/user_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class _Constants {
  static const buttonVerticalPadding = 10.0;
  static const buttonHorizontalPadding = 20.0;
  static const avatarRadius = 36.0;
  static const avatarSpacing = 15.0;
  static const userDataCornerRadius = 36.0;
  static const userDataPadding = 24.0;
  static const topOffsetFactor = 0.15;
}

class UserPage extends StatelessWidget {
  const UserPage(User user) : _user = user;

  final User _user;

  @override
  Widget build(BuildContext context) {
    final topOffset = MediaQuery.of(context).size.height * _Constants.topOffsetFactor;

    return Stack(
      children: [
        _buildUserHeader(topOffset, context),
        Positioned.fill(
          top: topOffset,
          child: _buildUserData(context),
        )
      ],
    );
  }

  Widget _buildUserData(BuildContext context) {
    return Container(
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(_Constants.userDataCornerRadius)),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(_Constants.userDataPadding),
                    child: Column(
                      children: [
                        UserSectionWidget(
                          title: Strings.current.tools,
                          children: [
                            UserSectionItem(
                              action: _navigateToLocationScreen,
                              label: Strings.current.location,
                              icon: Icons.map,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                PrimaryTextButton(
                  textPadding: const EdgeInsets.symmetric(
                    vertical: _Constants.buttonVerticalPadding,
                    horizontal: _Constants.buttonHorizontalPadding,
                  ),
                  onPressed: () => context.read<AuthenticationNotifier>().logout(),
                  text: Strings.current.logout,
                ),
              ],
            ),
          ),
        );
  }

  Widget _buildUserHeader(double topOffset, BuildContext context) {
    return SizedBox(
        height: topOffset,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: _Constants.avatarRadius,
              child: Icon(
                Icons.add,
                color: Theme.of(context).backgroundColor,
              ),
            ),
            const SizedBox(width: _Constants.avatarSpacing),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_user.name, style: Theme.of(context).textTheme.headline3),
                Text(_user.email, style: Theme.of(context).textTheme.bodyText1),
              ],
            )
          ],
        ),
      );
  }

  void _navigateToLocationScreen(BuildContext context) =>
      context.read<RoutePageManager>().openLocation();
}
