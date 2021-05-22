import 'package:flutter/material.dart';

ThemeData activeTheme;

final systemDefaultTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.cyan,
  accentColor: Colors.orange,
  cardColor: Colors.grey.shade300,
  splashColor: Colors.orange,
  appBarTheme: AppBarTheme(
    color: Colors.cyan,
  ),
);

final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.light(),
  primaryColor: Colors.cyan,
  accentColor: Colors.orange,
  cardColor: Colors.grey.shade300,
  brightness: Brightness.light,
  splashColor: Colors.orange,
  appBarTheme: AppBarTheme(
    color: Colors.cyan,
  ),
);

final darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey.shade800,
  colorScheme: ColorScheme.dark(),
  primaryColor: Colors.cyan,
  accentColor: Colors.cyan,
  canvasColor: Colors.white,
  cardColor: Colors.black38,
  splashColor: Colors.orange,
  appBarTheme: AppBarTheme(
    color: Colors.cyan,
  ),
);

final veryDarkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey.shade900,
  colorScheme: ColorScheme.dark(),
  primaryColor: Colors.cyan,
  accentColor: Colors.cyan,
  canvasColor: Colors.white,
  cardColor: Colors.black45,
  brightness: Brightness.dark,
  splashColor: Colors.orange,
  appBarTheme: AppBarTheme(
    color: Colors.cyan,
  ),
);
