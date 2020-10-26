import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/common/util/dimens.dart';
import 'package:allthenews/src/ui/common/util/untranslatable_strings.dart';
import 'package:allthenews/src/ui/common/widget/primary_icon_button.dart';
import 'package:allthenews/src/ui/pages/dashboard/dashboard_page.dart';
import 'package:allthenews/src/ui/pages/home/home_tab.dart';
import 'package:allthenews/src/ui/pages/profile/profile_page.dart';
import 'package:allthenews/src/ui/pages/settings/settings_notifier.dart';
import 'package:allthenews/src/ui/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class _Constants {
  static const appBarActionsVerticalPadding = 11.0;
  static const appBarActionsIconsPadding = 8.0;
  static const appBarTitleFontFamily = 'Chomsky';
  static const appBarTitleLeftPadding = 10.0;
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedPage = 0;
  List<HomeTab> _tabs;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabs = [
      HomeTab(page: DashboardPage(), appBar: _buildDashboardAppBar(context)),
      HomeTab(page: ProfilePage(), appBar: _buildProfileAppBar(context)),
    ];
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _tabs[_selectedPage].appBar,
        backgroundColor: Theme.of(context).backgroundColor,
        body: WillPopScope(
            onWillPop: () {
              if (_selectedPage == 0) {
                return Future.value(true);
              } else {
                setState(() {
                  _selectedPage = 0;
                });
                return Future.value(false);
              }
            },
            child: _tabs[_selectedPage].page),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (_selectedPage != index) {
              setState(() => _selectedPage = index);
            }
          },
          items: _buildBottomNavigationItems(),
          currentIndex: _selectedPage,
        ),
      );

  List<BottomNavigationBarItem> _buildBottomNavigationItems() => [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: UntranslatableStrings.news,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.account_circle),
          label: Strings.current.profile,
        ),
      ];

  PreferredSizeWidget _buildDashboardAppBar(BuildContext context) {
    return AppBar(
      brightness: Theme.of(context).brightness,
      elevation: Dimens.appBarElevation,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Padding(
        padding: const EdgeInsets.only(left: _Constants.appBarTitleLeftPadding),
        child: Text(
          UntranslatableStrings.newYorkTimes,
          style: Theme.of(context)
              .textTheme
              .headline2
              .copyWith(fontFamily: _Constants.appBarTitleFontFamily),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: _Constants.appBarActionsVerticalPadding,
          ),
          child: PrimaryIconButton(
            iconData: Icons.search,
            onPressed: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: _Constants.appBarActionsVerticalPadding,
            bottom: _Constants.appBarActionsVerticalPadding,
            right: Dimens.pagePadding,
            left: _Constants.appBarActionsIconsPadding,
          ),
          child: PrimaryIconButton(
            iconData: Icons.settings,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (_) => inject<SettingsNotifier>(),
                    child: SettingsPage(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildProfileAppBar(BuildContext context) {
    return AppBar(
      brightness: Theme.of(context).brightness,
      elevation: Dimens.appBarElevation,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Padding(
        padding: const EdgeInsets.only(left: _Constants.appBarTitleLeftPadding),
        child: Text(
          Strings.of(context).profile,
          style: Theme.of(context)
              .textTheme
              .headline2
              .copyWith(fontFamily: _Constants.appBarTitleFontFamily),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            top: _Constants.appBarActionsVerticalPadding,
            bottom: _Constants.appBarActionsVerticalPadding,
            right: Dimens.pagePadding,
            left: _Constants.appBarActionsIconsPadding,
          ),
          child: PrimaryIconButton(
            iconData: Icons.settings,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (_) => inject<SettingsNotifier>(),
                    child: SettingsPage(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
