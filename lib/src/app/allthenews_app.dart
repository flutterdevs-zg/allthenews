import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/app/firebase_app_initializer.dart';
import 'package:allthenews/src/app/navigation/app_router_delegate.dart';
import 'package:allthenews/src/app/navigation/app_router_information_parser.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/common/theme/theme_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class AllTheNewsApp extends StatefulWidget {
  @override
  _AllTheNewsAppState createState() => _AllTheNewsAppState();
}

class _AllTheNewsAppState extends State<AllTheNewsApp> {
  final ThemeNotifier _themeNotifier = inject<ThemeNotifier>();
  final AppRouterDelegate _appRouterDelegate = AppRouterDelegate();
  final AppRouteInformationParser _appRouteInformationParser = AppRouteInformationParser();
  final Future<FirebaseApp> _firebaseInitializer = inject<FirebaseInitializer>().initializeFirebaseApp();

  @override
  void initState() {
    super.initState();
    _themeNotifier.initTheme();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInitializer,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildFirebaseInitializationError();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
          return _buildAppContent(context);
        }
        return _buildProgressIndicator();
      },
    );
  }

  Widget _buildAppContent(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _themeNotifier,
      builder: (providerContext, child) {
        if (providerContext.select((ThemeNotifier notifier) => notifier.isLoading)) {
          return _buildProgressIndicator();
        } else {
          return _buildMaterialApp(providerContext);
        }
      },
    );
  }

  Widget _buildMaterialApp(BuildContext context) {
    return MaterialApp.router(
      theme: context.select((ThemeNotifier notifier) => notifier.themeData),
      localizationsDelegates: const [
        Strings.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: Strings.delegate.supportedLocales,
      routerDelegate: _appRouterDelegate,
      routeInformationParser: _appRouteInformationParser,
    );
  }

  Widget _buildProgressIndicator() => const Center(child: CircularProgressIndicator());

  Widget _buildFirebaseInitializationError() =>
      Center(child: Text(Strings.current.initializationError));
}
