import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;
  ThemeData get getTheme => _themeData;
  ThemeProvider(this._themeData);
  setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
