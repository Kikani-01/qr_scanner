import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qr_scann/ThemeProvider/type_of_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Controller/Intro_screen.dart';
import 'ThemeProvider/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((value) {
    var themeColor = value.getString("ThemeMode");
    if (themeColor == 'System Default') {
      activeTheme = systemDefaultTheme;
    } else if (themeColor == 'Light Theme') {
      activeTheme = lightTheme;
    } else if (themeColor == 'Dark Theme') {
      activeTheme = darkTheme;
    } else if (themeColor == 'Very Dark') {
      activeTheme = veryDarkTheme;
    } else {
      activeTheme = systemDefaultTheme;
    }
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => ThemeProvider(activeTheme))
        ],
        child: IntroScreen(),
      ),
    );
  });
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "QR SCAN",
      theme: themeProvider.getTheme,
      home: Scaffold(
        body: Container(
          child: Center(
            child: GetBuilder<Intro>(
              init: Intro(),
              builder: (value) => CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
