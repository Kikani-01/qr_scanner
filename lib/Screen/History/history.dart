import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:qr_scann/Controller/history_controller.dart';
import 'package:qr_scann/DataBase/getdata.dart';
import 'package:qr_scann/Pages/Ads/add.dart';
import 'package:share/share.dart';

import 'history_in_brief.dart';

class History extends StatelessWidget {
  final control = Get.put(HistoryController());

  // String add = "add to Favourite";
  // bool isFavorite = true;
  @override
  Widget build(BuildContext context) {
    print('History');
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.088,
            color: Colors.black26,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(control.count.value.toString()),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Row(
                    children: [
                      // Don't know what is'
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          deleteAll(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: GetBuilder<HistoryController>(
              init: control.updateListView(),
              builder: (value) => Obx(
                () => SingleChildScrollView(
                  child: Column(
                    children: [
                      control.count.value != 0
                          ? Container(
                              height: MediaQuery.of(context).size.height * 0.65,
                              child: ListView.builder(
                                itemCount: control.count.value,
                                // reverse: true,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      control.noteList[index].saveResult,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    subtitle: Text(control.noteList[index].date
                                        .toString()),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Obx(
                                          () => IconButton(
                                            icon:
                                                control.favourite.value == false
                                                    ? control.noteList[index]
                                                                .isFavourite ==
                                                            1
                                                        ? Container()
                                                        : Icon(Icons.star)
                                                    : control.noteList[index]
                                                                .isFavourite ==
                                                            1
                                                        ? Container()
                                                        : Icon(Icons.star),
                                            onPressed: () {
                                              control.favoriteChangeMain(index);
                                            },
                                          ),
                                        ),
                                        popMenu(
                                            context, control.noteList[index]),
                                      ],
                                    ),
                                    onLongPress: () {
                                      print("onLongPress");
                                    },
                                    onTap: () {
                                      _navigateToDetail(
                                          control.noteList[index]);
                                    },
                                  );
                                },
                              ),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height * 0.68,
                              child: Center(
                                  child: Text(
                                "Your scans will be listed here.",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => Get.to(Ads()),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                color: Colors.cyan,
                child: Column(
                  children: [
                    Text("Remove Ads"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void delete(BuildContext context, Databasedata databasedata) async {
    var delete = await control.helper.deleteNote(databasedata.id);
    if (delete != 0) {
      control.updateListView();
      Get.snackbar('Successfully', '1 entry Deleted.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.black,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          duration: Duration(milliseconds: 1000),
          margin: EdgeInsets.all(10));
    }
  }

  void deleteAll(context) {
    Get.defaultDialog(
        title: "Delete",
        content: Container(
          height: MediaQuery.of(context).size.height * 0.12,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info,
                color: Colors.red,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                // color: Colors.cyan,
                child: Text("Do you want to delete all history ?"),
              ),
            ],
          ),
        ),
        onCancel: () {
          Get.back();
        },
        textConfirm: "    Delete    ",
        textCancel: "    Cancel    ",
        confirmTextColor: Colors.white,
        onConfirm: () async {
          var delete = await control.helper.deleteAll();
          Get.back();
          if (delete != 0) {
            control.updateListView();
            Get.snackbar("Delete", 'Delete your entire history',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white,
                dismissDirection: SnackDismissDirection.HORIZONTAL,
                margin: EdgeInsets.all(10));
          }
        });
  }

  void _navigateToDetail(Databasedata databasedata) async {
    bool result = await Get.to(() => HistoryBrief(databasedata));
    if (result == null) {
      control.updateListView();
    } else {
      control.updateListView();
    }
  }

  MenuOption select;

  Widget popMenu(context, Databasedata databasedata) {
    return PopupMenuButton<MenuOption>(
      onSelected: (MenuOption result) {
        select = result;
        switch (select) {
          case MenuOption.CSV:
            {}
            break;
          case MenuOption.TXT:
            {
              context.findRenderObject();
              Share.share(
                databasedata.saveResult,
                subject: databasedata.saveResult,
              );
            }
            break;
          case MenuOption.Delete:
            {
              delete(context, databasedata);
            }
            break;
        }
      },
      child: Icon(Icons.more_vert),
      itemBuilder: (context) => <PopupMenuEntry<MenuOption>>[
        PopupMenuItem(
          child: Text("CSV"),
          value: MenuOption.CSV,
        ),
        PopupMenuItem(
          child: Text("TXT"),
          value: MenuOption.TXT,
        ),
        PopupMenuItem(
          child: Text("Delete"),
          value: MenuOption.Delete,
        ),
      ],
    );
  }
}

enum MenuOption {
  CSV,
  TXT,
  Delete,
}
