import 'package:flutter/foundation.dart';

extension ChangeNotifierTextExtensions on ChangeNotifier {
  void verifyStateInOrder({
    @required Function() testFunction,
    @required List<Function()> matchersMethods,
  }) {
    int index = 0;
    addListener(() {
      matchersMethods[index]();
      index++;
    });
    testFunction();
  }
}
