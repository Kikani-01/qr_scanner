import 'package:get/get.dart';
import 'package:qr_scann/DataBase/CustomSearch/custom_databasehelper.dart';
import 'package:qr_scann/DataBase/CustomSearch/custom_search_data.dart';
import 'package:sqflite/sqflite.dart';

class CustomSearchOptionController extends GetxController {
  RxInt count = 0.obs;

  CustomDataHelper customDataHelper = CustomDataHelper();
  List<CustomSearchData> customDataList;

  updateListView() {
    final Future<Database> dbFuture = customDataHelper.initDb();
    dbFuture.then((database) {
      Future<List<CustomSearchData>> noteListFuture = customDataHelper.data();
      noteListFuture.then((index) {
        customDataList = index;
        count.value = index.length;
      });
    });
  }
}
