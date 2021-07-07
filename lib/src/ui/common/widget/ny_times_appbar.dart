import 'package:allthenews/src/app/navigation/route_page_manager.dart';
import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/widget/primary_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class _Constants {
  static const appBarActionsVerticalPadding = 11.0;
  static const appBarActionsIconsPadding = 8.0;
  static const appBarTitleFontFamily = 'Chomsky';
  static const appBarTitleLeftPadding = 10.0;
}

class NyTimesAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool hasSettingsAction;
  final bool hasSearchAction;
  final bool hasBackButton;
  final VoidCallback? backButtonAction;

  const NyTimesAppBar({
    this.title = "",
    this.backButtonAction,
    this.hasBackButton = false,
    this.hasSettingsAction = false,
    this.hasSearchAction = false,
  });

  @override
  _NyTimesAppBarState createState() => _NyTimesAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NyTimesAppBarState extends State<NyTimesAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.hasBackButton
          ? IconButton(
              color: Theme.of(context).indicatorColor,
              onPressed: widget.backButtonAction,
              icon: const Icon(Icons.arrow_back_ios),
            )
          : null,
      brightness: Theme.of(context).brightness,
      elevation: Dimens.appBarElevation,
      iconTheme: const IconThemeData(color: Colors.black),
      title: _getAppBarTitle(widget.title),
      backgroundColor: Theme.of(context).backgroundColor,
      actions: _buildAppBarActions(),
    );
  }

  List<Widget> _buildAppBarActions() => [
        if (widget.hasSearchAction) _buildSearchAction(),
        if (widget.hasSettingsAction) _buildSettingsAction(),
      ];

  Widget _getAppBarTitle(String title) => Padding(
        padding: const EdgeInsets.only(left: _Constants.appBarTitleLeftPadding),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline2!.copyWith(
                fontFamily: _Constants.appBarTitleFontFamily,
              ),
        ),
      );

  Widget _buildSearchAction() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: _Constants.appBarActionsVerticalPadding,
      ),
      child: PrimaryIconButton(
        iconData: Icons.search,
        onPressed: () {},
      ),
    );
  }

  Widget _buildSettingsAction() => Padding(
        padding: const EdgeInsets.only(
          top: _Constants.appBarActionsVerticalPadding,
          bottom: _Constants.appBarActionsVerticalPadding,
          right: Dimens.pagePadding,
          left: _Constants.appBarActionsIconsPadding,
        ),
        child: PrimaryIconButton(
          iconData: Icons.settings,
          onPressed: () => context.read<RoutePageManager>().openSettings(),
        ),
      );
}
