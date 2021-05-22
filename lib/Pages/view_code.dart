import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qr_scann/DataBase/databasehelper.dart';
import 'package:qr_scann/DataBase/getdata.dart';
import 'package:qr_scann/Screen/Create/create_all_result.dart';
import 'package:share/share.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewCode extends StatelessWidget {
  var result;
  var type;
  var date;
  int isFavourite;
  ViewCode({this.result, this.type, this.date, this.isFavourite});

  DatabaseHelper helper = DatabaseHelper();
  Databasedata databasedata = Databasedata();
  List noteList = <Databasedata>[].obs;
  MenuOption select;
  var format;
  var codeScanner;

  var add = "Add to favourites".obs;

  final TextEditingController _textController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print("Could not launch $command ");
    }
  }

  @override
  Widget build(BuildContext context) {
    databasedata.isFavourite = isFavourite;
    if (type != null)
      format = type.split("BarcodeFormat.").join("").toString().toUpperCase();
    if (type != null) format = "Qr code";
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp),
            onPressed: () {
              sendDataBack(context);
            }),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          format,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _delete(context, databasedata);
              sendDataBack(context);
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
          popMenu(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                child: Text(
                  result,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  customLaunch(result);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                format,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
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
                            icon: databasedata.isFavourite == 1
                                ? Icon(Icons.star_border)
                                : Icon(Icons.star),
                            onPressed: () {
                              favourite();
                            }),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            showAlertDialog();
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
                customLaunch(result);
              },
            ),
          ],
        ),
      ),
    );
  }

  void sendDataBack(BuildContext context) {
    bool send;
    Navigator.pop(context, send);
  }

  favourite() {
    if (databasedata.isFavourite == 1) {
      _save();
      add.value = "Remove to favourite";
      databasedata.isFavourite = 2;
    } else if (databasedata.isFavourite == 2) {
      _save();
      add.value = "Add to favourite";
      databasedata.isFavourite = 1;
    }
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
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text("Copied to clipboard")));
    Clipboard.setData(new ClipboardData(text: result));
  }

  showAlertDialog() {
    Get.defaultDialog(
      content: TextFormField(
        controller: _textController,
        validator: (value) => value.isEmpty ? "Required" : null,
        decoration: InputDecoration(
          hintText: "Notes",
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
        ),
        cursorColor: Colors.orange,
      ),
      onConfirm: () {},
      textConfirm: 'OK',
      onCancel: () {
        Get.back();
      },
      textCancel: 'Cancel',
    );
  }

  Widget popMenu() {
    return PopupMenuButton<MenuOption>(
      onSelected: (MenuOption result) {
        select = result;
        switch (select) {
          case MenuOption.Favorites:
            {
              favourite();
            }
            break;
          case MenuOption.Notes:
            {
              showAlertDialog();
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

  void _save() async {
    var save;
    if (databasedata.isFavourite == 2) {
      save = await helper.updateNote(databasedata);
    } else {
      save = await helper.updateNote(databasedata);
    }
  }
}

enum MenuOption {
  Favorites,
  Notes,
  Copy,
}
