import 'package:get/get.dart';
import 'package:qr_scann/DataBase/databasehelper.dart';
import 'package:qr_scann/DataBase/getdata.dart';
import 'package:sqflite/sqflite.dart';

class HistoryController extends GetxController {
/*  @override
  void onInit() {
    super.onInit();
    updateListView();
  }*/

  Databasedata databasedata = Databasedata();
  DatabaseHelper helper = DatabaseHelper();
  List<Databasedata> noteList;
  var count = 0.obs;

  updateListView() {
    final Future<Database> dbFuture = helper.initDb();
    dbFuture.then((database) {
      Future<List<Databasedata>> noteListFuture = helper.data();
      noteListFuture.then((index) {
        noteList = index;
        count.value = index.length;
      });
    });
  }
}
