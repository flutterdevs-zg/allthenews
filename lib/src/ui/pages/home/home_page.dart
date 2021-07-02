import 'package:allthenews/src/ui/pages/home/bottom_bar_notifier.dart';
import 'package:allthenews/src/ui/pages/home/bottom_bar_router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final BottomBarNotifier _bottomBarNotifier;

  const HomePage(this._bottomBarNotifier);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BottomBarRouterDelegate _routerDelegate;
  ChildBackButtonDispatcher? _backButtonDispatcher;

  @override
  void initState() {
    super.initState();
    _routerDelegate = BottomBarRouterDelegate(widget._bottomBarNotifier);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _backButtonDispatcher =
        Router.of(context).backButtonDispatcher?.createChildBackButtonDispatcher();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _routerDelegate.bottomBarNotifier = widget._bottomBarNotifier;
  }

  @override
  Widget build(BuildContext context) {
    _backButtonDispatcher?.takePriority();
    return ChangeNotifierProvider.value(
      value: widget._bottomBarNotifier,
      builder: (providerContext, child) {
        final index = providerContext.select((BottomBarNotifier state) => state.selectedIndex);
        return Scaffold(
          appBar: _routerDelegate.appBar,
          backgroundColor: Theme.of(context).backgroundColor,
          body: WillPopScope(
            onWillPop: () => _routerDelegate.onWillPop(),
            child: Router(
              routerDelegate: _routerDelegate,
              backButtonDispatcher: _backButtonDispatcher,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) => providerContext.read<BottomBarNotifier>().selectedIndex = index,
            items: _routerDelegate.buildBottomNavigationItems(),
            currentIndex: index,
          ),
        );
      },
    );
  }
}
