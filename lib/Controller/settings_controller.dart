import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:package_info/package_info.dart';
import 'package:qr_scann/ThemeProvider/theme.dart';
import 'package:qr_scann/ThemeProvider/type_of_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  RxString selectedTheme = "System Default".obs;
  List themes = <String>[
    "System Default",
    "Light Theme",
    "Dark Theme",
    "Very Dark"
  ];

  themeChangeDialog(ThemeProvider themeProvider) async => Get.defaultDialog(
        title: "Choose Theme",
        content: Column(children: [
          RadioGroup<String>.builder(
            groupValue: selectedTheme.value,
            onChanged: (value) async {
              selectedTheme.value = value;
              onThemeChange(selectedTheme.value, themeProvider);
              Get.back();
            },
            items: themes,
            itemBuilder: (item) => RadioButtonBuilder(item),
          ),
        ]),
        onCancel: () {
          Get.back();
        },
        textCancel: "Cancel",
      );

  void onThemeChange(String value, ThemeProvider themeProvider) async {
    if (value == 'System Default') {
      themeProvider = themeProvider.setTheme(systemDefaultTheme);
    } else if (value == 'Light Theme') {
      themeProvider = themeProvider.setTheme(lightTheme);
    } else if (value == 'Dark Theme') {
      themeProvider = themeProvider.setTheme(darkTheme);
    } else {
      themeProvider = themeProvider.setTheme(veryDarkTheme);
    }
    final pref = await SharedPreferences.getInstance();
    pref.setString("ThemeMode", value);
  }

  @override
  void onInit() {
    super.onInit();
    loadValue();
  }

  RxBool openWebsite = false.obs;
  RxBool continuous = false.obs;
  RxBool duplicate = false.obs;
  RxBool confirm = false.obs;
  RxBool sound = true.obs;
  RxBool vibrate = true.obs;
  RxBool copy = true.obs;
  RxBool productsInformation = true.obs;
  RxBool usageStatistics = false.obs;

  saveInSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("openWebsite", openWebsite.value);
    pref.setBool("continuous", continuous.value);
    pref.setBool("duplicate", duplicate.value);
    pref.setBool("confirm", confirm.value);
    pref.setBool("sound", sound.value);
    pref.setBool("vibrate", vibrate.value);
    pref.setBool("copy", copy.value);
    pref.setBool("productsInformation", productsInformation.value);
    pref.setBool("usageStatistics", usageStatistics.value);
  }

  //Camera change
  RxString selectedCamera = "Back Camera".obs;
  List cameras = <String>["Back Camera", "Front Camera"];

  changeCamera() async {
    return Get.defaultDialog(
      title: "Change Camera",
      content: RadioGroup<String>.builder(
        groupValue: selectedCamera.value,
        onChanged: (value) async {
          onChangeCamera(value);
          update();
        },
        items: cameras,
        itemBuilder: (item) => RadioButtonBuilder(item),
      ),
      onCancel: () {
        Get.back();
      },
      textCancel: "Cancel",
    );
  }

  onChangeCamera(value) async {
    selectedCamera.value = value;
    Get.back();
    final pref = await SharedPreferences.getInstance();
    pref.setString("ChangeCamera", value);
  }

  Future<void> loadValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    selectedTheme.value = pref.getString("ThemeMode") ?? "System Default";
    openWebsite.value = pref.getBool("openWebsite") ?? false;
    continuous.value = pref.getBool("continuous") ?? false;
    duplicate.value = pref.getBool("duplicate") ?? false;
    confirm.value = pref.getBool("confirm") ?? false;
    sound.value = pref.getBool("sound") ?? false;
    vibrate.value = pref.getBool("vibrate") ?? false;
    copy.value = pref.getBool("copy") ?? false;
    productsInformation.value = pref.getBool("productsInformation") ?? false;
    usageStatistics.value = pref.getBool("usageStatistics") ?? false;
    selectedCamera.value = pref.getString("ChangeCamera") ?? "Back Camera";
  }

  toggleVibrate(bool value) {
    vibrate.value = value;
    saveInSharedPref();
  }
}
