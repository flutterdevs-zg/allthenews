import 'package:firebase_core/firebase_core.dart';

abstract class FirebaseInitializer {
  Future<FirebaseApp> initializeFirebaseApp();
}

class FirebaseAppInitializer extends FirebaseInitializer {
  @override
  Future<FirebaseApp> initializeFirebaseApp() => Firebase.initializeApp();
}
