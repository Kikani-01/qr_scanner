import 'dart:async';

import 'package:get/get.dart';
import 'package:qr_scann/Pages/ScanProduct/scan_product.dart';
import 'package:qr_scann/Screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intro extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(Duration(milliseconds: 100), oneTimeScreen);
  }

  oneTimeScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool alredyVisited = preferences.getBool("alredyVisited") ?? false;
    if (alredyVisited) {
      Get.off(() => Home());
    } else {
      preferences.setBool("alredyVisited", true);
      Get.off(() => ScanProduct());
    }
  }
}
