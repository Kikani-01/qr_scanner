import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSearchAndEditController extends GetxController {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  RxBool execute = false.obs;

  executeSetValue() async {
    await SharedPreferences.getInstance().then((value) {
      final counter = value.getBool("executeChange");
      if (counter == null) {
        value.setBool("executeChange", false);
        execute.value = false;
      } else {
        execute.value = counter;
      }
    });
    update();
  }
}
