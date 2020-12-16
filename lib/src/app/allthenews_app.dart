import 'package:allthenews/generated/l10n.dart';
import 'package:allthenews/src/app/firebase_app_initializer.dart';
import 'package:allthenews/src/di/injector.dart';
import 'package:allthenews/src/ui/common/theme/theme_notifier.dart';
import 'package:allthenews/src/ui/pages/home/home_page.dart';
import 'package:allthenews/src/ui/pages/presentation/presentation_notifier.dart';
import 'package:allthenews/src/ui/pages/presentation/presentation_page.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class AllTheNewsApp extends StatefulWidget {
  @override
  _AllTheNewsAppState createState() => _AllTheNewsAppState();
}

class _AllTheNewsAppState extends State<AllTheNewsApp> {
  final FirebaseInitializer _firebaseInitializer = inject<FirebaseInitializer>();

  @override
  void initState() {
    super.initState();
    context.read<PresentationNotifier>().checkAppPresentation();
    context.read<ThemeNotifier>().initTheme();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInitializer.initializeFirebaseApp(),
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
    if (context.select((ThemeNotifier notifier) => notifier.isLoading) ||
        context.select((PresentationNotifier notifier) => notifier.isLoading)) {
      return _buildProgressIndicator();
    } else {
      return _buildMaterialApp(context);
    }
  }

  Widget _buildMaterialApp(BuildContext context) {
    return MaterialApp(
      theme: context.select((ThemeNotifier notifier) => notifier.themeData),
      home: context.select((PresentationNotifier notifier) => notifier.shouldShowPresentation)
          ? PresentationPage()
          : HomePage(),
      localizationsDelegates: const [
        Strings.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: Strings.delegate.supportedLocales,
    );
  }

  Widget _buildProgressIndicator() => const Center(child: CircularProgressIndicator());

  Widget _buildFirebaseInitializationError() => Center(child: Text(Strings.current.initializationError));
}
