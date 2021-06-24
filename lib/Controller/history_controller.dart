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
  RxBool favorite = true.obs;
  var count = 0.obs;
  var add = "Add to favourites".obs;

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

  favoriteChange(databasedata) async {
    var save;
    if (databasedata.isFavourite == 1) {
      databasedata.isFavourite = 2;
      update();
      save = await helper.updateNote(databasedata);
      add.value = "Remove from favourites";
      favorite.value = false;
    } else {
      databasedata.isFavourite = 1;
      update();

      save = await helper.updateNote(databasedata);
      add.value = "Add to favourites";
      favorite.value = true;
    }
    update();
  }

  favoriteChangeMain(index) async {
    var save;
    if (noteList[index].isFavourite == 1) {
      noteList[index].isFavourite = 2;
      save = await helper.updateNote(noteList[index]);
      add.value = "Remove from favourites";
      favorite.value = false;
    } else {
      noteList[index].isFavourite = 1;
      save = await helper.updateNote(noteList[index]);
      favorite.value = true;
      add.value = "Add to favourites";
    }
    update();
  }
}
