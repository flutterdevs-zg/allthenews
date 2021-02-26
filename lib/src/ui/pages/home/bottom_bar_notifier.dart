import 'package:flutter/material.dart';

class BottomBarNotifier extends ChangeNotifier {
  int _selectedIndex;

  BottomBarNotifier() : _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    if (index != _selectedIndex) {
      _selectedIndex = index;
      notifyListeners();
    }
  }
}