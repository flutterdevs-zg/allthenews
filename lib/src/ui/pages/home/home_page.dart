import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/common/util/untranslatable_strings.dart';
import 'package:allthenews/src/ui/common/widget/ny_times_appbar.dart';
import 'package:allthenews/src/ui/pages/dashboard/dashboard_page.dart';
import 'package:allthenews/src/ui/pages/home/home_page_notifier.dart';
import 'package:allthenews/src/ui/pages/home/home_tab.dart';
import 'package:allthenews/src/ui/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final int initialPage;

  const HomePage({this.initialPage = 0});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageNotifier _homePageNotifier = inject<HomePageNotifier>();

  List<HomeTab> _tabs;

  @override
  void initState() {
    super.initState();
    _homePageNotifier.setSelectedPage(widget.initialPage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabs = _buildHomeTabs();
  }

  List<HomeTab> _buildHomeTabs() {
    return [
      HomeTab(
          page: DashboardPage(),
          appBar: const NyTimesAppBar(
            title: UntranslatableStrings.newYorkTimes,
            hasSearchAction: true,
            hasSettingsAction: true,
          )),
      HomeTab(
          page: ProfilePage(),
          appBar: NyTimesAppBar(
            title: Strings.current.profile,
          ))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _homePageNotifier,
      builder: (providerContext, child) {
        final selectedPage =
            providerContext.select((HomePageNotifier notifier) => notifier.selectedPage);

        return Scaffold(
          appBar: _tabs[selectedPage].appBar,
          backgroundColor: Theme.of(context).backgroundColor,
          body: WillPopScope(
              onWillPop: () {
                if (selectedPage == 0) {
                  return Future.value(true);
                } else {
                  providerContext.read<HomePageNotifier>().setSelectedPage(0);
                  return Future.value(false);
                }
              },
              child: _tabs[selectedPage].page),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              if (selectedPage != index) {
                providerContext.read<HomePageNotifier>().setSelectedPage(index);
              }
            },
            items: _buildBottomNavigationItems(),
            currentIndex: selectedPage,
          ),
        );
      },
    );
  }

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
}
