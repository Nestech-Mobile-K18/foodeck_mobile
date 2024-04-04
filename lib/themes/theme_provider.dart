import 'package:flutter/material.dart';
import 'package:template/themes/dark_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = ThemeData.light();

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == ThemeData.light()) {
      themeData = darkMode;
    } else {
      themeData = ThemeData.light();
    }
  }
}
