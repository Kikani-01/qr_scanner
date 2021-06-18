import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qr_scann/Controller/result_qr_code.dart';
import 'package:qr_scann/DataBase/databasehelper.dart';
import 'package:qr_scann/DataBase/getdata.dart';
import 'package:qr_scann/Screen/Create/create_all_result.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

enum MenuOption {
  Favorites,
  Notes,
  Copy,
}

class ResultQRPage extends StatelessWidget {
  DatabaseHelper helper = DatabaseHelper();
  Databasedata databasedata = Databasedata();
  List<Databasedata> noteList;
  final init = Get.put(ScanController());
  var result;
  var type;
  var date;
  int isFavourite;
  ResultQRPage(this.result, this.type, this.date);
  MenuOption select;
  var add = "Add to favourites".obs;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print("Could not launch $command");
    }
  }

  var openWebSite = false.obs;

  openWebAuto() async {
    await SharedPreferences.getInstance().then((value) async {
      final openWebsite = value.getBool("openWebsite");
      if (openWebsite == null) {
        openWebSite.value = false;
      } else {
        openWebSite.value = openWebsite;
      }
      if (openWebSite.value) {
        customLaunch(result);
      }
    });
  }

  Future<bool> onWillPop() async {
    Get.back(result: true);
  }

  @override
  Widget build(BuildContext context) {
    openWebAuto();
    save();

    var format = type.split("BarcodeFormat.").join("").toUpperCase();
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_sharp),
              onPressed: () {
                onWillPop();
              }),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.cyan,
          title: Text(
            format,
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _delete(context, databasedata);
                onWillPop();
              },
            ),
            Builder(builder: (context) {
              return IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    context.findRenderObject();
                    Share.share(
                      result,
                      subject: result,
                    );
                  });
            }),
            popMenu(context),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        child: Text(
                          result.toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onTap: () {
                          // customLaunch(init.result);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(format,
                          style: TextStyle(
                            fontSize: 15,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        bottom: 20.0,
                      ),
                      child: Text(
                        date,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.orange,
                      splashColor: Colors.orange[200],
                      onTap: () {
                        Get.to(CreateAllResult(result, format, date));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                        child: Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                FontAwesomeIcons.barcode,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 23,
                            ),
                            Text(
                              "View code",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                              ),
                            ),
                            Spacer(
                              flex: 2,
                            ),
                            Row(
                              children: [
                                IconButton(
                                    icon: Icon(Icons.star_border),
                                    onPressed: () {}),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    // showAlertDialog(context);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.copy),
                                  onPressed: () {
                                    _copyClipboard();
                                  },
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          Icons.open_in_browser,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "Open website",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                        ),
                      ),
                      onTap: () {
                        customLaunch(init.result);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.cyan,
                child: Column(
                  children: [
                    Text("Remove Ads"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void save() async {
    databasedata.saveResult = result.toString();
    databasedata.date = date.toString();
    databasedata.isFavourite = 1;
    var save;
    if (databasedata.id != null) {
      save = await helper.updateNote(databasedata);
    } else {
      save = await helper.insertNote(databasedata);
    }
    print("++");
  }

  void _delete(BuildContext context, Databasedata databasedata) async {
    int result = await helper.deleteNote(databasedata.id);
    if (result != 0) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = helper.initDb();
    dbFuture.then((database) {
      Future<List<Databasedata>> noteListFuture = helper.data();
      noteListFuture.then((value) {
        this.noteList = value;
      });
    });
  }

  void _copyClipboard() {
    Get.snackbar("Copied", "Copied to clipboard",
        margin: EdgeInsets.all(10), snackPosition: SnackPosition.BOTTOM);
    Clipboard.setData(ClipboardData(text: result));
  }

  Widget popMenu(context) {
    return PopupMenuButton<MenuOption>(
      onSelected: (MenuOption result) {
        select = result;
        switch (select) {
          case MenuOption.Favorites:
            {
              // favourite();
            }
            break;
          case MenuOption.Notes:
            {
              // showAlertDialog(context);
            }
            break;
          case MenuOption.Copy:
            {
              _copyClipboard();
            }
            break;
        }
      },
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      itemBuilder: (context) => <PopupMenuEntry<MenuOption>>[
        PopupMenuItem(
          child: Obx(
            () => Text(add.value),
          ),
          value: MenuOption.Favorites,
        ),
        PopupMenuItem(
          child: Text("Notes"),
          value: MenuOption.Notes,
        ),
        PopupMenuItem(
          child: Text("Copy Code"),
          value: MenuOption.Copy,
        )
      ],
    );
  }

  // void _save() async {
  //   var save;
  //   if (databasedata.isFavourite == 2) {
  //     save = await helper.updateNote(databasedata);
  //   } else {
  //     save = await helper.updateNote(databasedata);
  //   }
  // }
}
