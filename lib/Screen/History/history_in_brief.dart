import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_scann/Controller/history_controller.dart';
import 'package:qr_scann/DataBase/databasehelper.dart';
import 'package:qr_scann/DataBase/getdata.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryBrief extends StatelessWidget {
  Databasedata databasedata = Databasedata();
  DatabaseHelper helper = DatabaseHelper();
  var add = "Add to favourites".obs;
  final control = Get.put(HistoryController());
  HistoryBrief(this.databasedata);

  MenuOption select;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _textController = TextEditingController();

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print("Could not launch $command ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.cyan,
        title: Text(
          "History",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              delete(context);
            },
          ),
          Builder(builder: (context) {
            return IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  final RenderBox box = context.findRenderObject();
                  Share.share(databasedata.saveResult,
                      subject: databasedata.saveResult,
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size);
                });
          }),
          popMenu(),
        ],
      ),
      body: Builder(
        builder: (context) => Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    child: SelectableText(
                      databasedata.saveResult,
                      cursorColor: Colors.red,
                      showCursor: false,
                      autofocus: false,
                      enableInteractiveSelection: true,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      customLaunch(databasedata.saveResult);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "QR Code",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Text(
                    databasedata.date,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
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
                          Icons.qr_code,
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
                              onPressed: () {
                                // favourite();
                              }),
                          /*InkWell(
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Icon(Icons.edit),
                            ),
                            onTap: () {
                              showAlertDialog();
                            },
                          ),*/
                          InkWell(
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Icon(Icons.copy),
                            ),
                            onTap: () {
                              copyClipboard();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: ListTile(
                    leading: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        Icons.open_in_browser,
                        color: Colors.white,
                        size: 20,
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
                      customLaunch(databasedata.saveResult);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

/*
  void _save() async {
    var save;
    if (databasedata.isFavourite == 2) {
      save = await helper.updateNote(databasedata);
    } else {
      save = await helper.updateNote(databasedata);
    }
  }
*/

  void delete(BuildContext context) async {
    await helper.deleteNote(databasedata.id);
    control.updateListView();
    Get.back();
    Get.snackbar('Successfully', '1 entry Deleted.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        duration: Duration(milliseconds: 1000),
        margin: EdgeInsets.all(10));
  }

  void copyClipboard() {
    Get.snackbar("Copied", "Copied to clipboard",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.black,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.white);
    Clipboard.setData(ClipboardData(text: databasedata.saveResult));
  }

  showAlertDialog() {
    Get.defaultDialog(
      title: "Notes",
      content: Padding(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            controller: _textController,
            validator: (value) => value.isEmpty ? "Required" : null,
            decoration: InputDecoration(
              hintText: "Title",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
            ),
            cursorColor: Colors.orange,
          )),
      textConfirm: "Save",
      confirmTextColor: Colors.white,
      onCancel: () {
        Get.back();
      },
      onConfirm: () {},
    );
  }

  Widget popMenu() {
    return PopupMenuButton<MenuOption>(
      onSelected: (MenuOption result) {
        select = result;
        switch (select) {
          case MenuOption.Favorites:
            {
              // favourite();
            }
            break;
          /*case MenuOption.Notes:
            {
              showAlertDialog();
            }
            break;*/
          case MenuOption.Copy:
            {
              copyClipboard();
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
          child: Text(add.value),
          value: MenuOption.Favorites,
        ),
        /*PopupMenuItem(
          child: Text("Notes"),
          value: MenuOption.Notes,
        ),*/
        PopupMenuItem(
          child: Text("Copy Code"),
          value: MenuOption.Copy,
        )
      ],
    );
  }
}

enum MenuOption {
  Favorites,
  Copy,
}
