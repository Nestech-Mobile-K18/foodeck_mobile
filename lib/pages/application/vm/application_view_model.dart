import 'package:flutter/material.dart';

class ApplicationViewModel with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  // Function returns the color of the icon based on the tab index
  Color getColor(int index) {
    return _selectedIndex == index ? Colors.pink : Colors.grey;
  }

  // Handle when selecting a tab
  void onItemTapped(int index) {
    _selectedIndex = index;
    // Notify the listeners (widgets) that the state has changed
    notifyListeners();
  }
}
