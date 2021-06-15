import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scann/Controller/history_controller.dart';
import 'package:qr_scann/DataBase/getdata.dart';
import 'package:qr_scann/Pages/Ads/add.dart';

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
                      // Don't know what is
                      Text("Export"),
                      SizedBox(
                        width: 15,
                      ),
                      // Don't know what is'
                      Text("Import"),
                      SizedBox(
                        width: 10,
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
                      if (control.count.value == 0)
                        Container(
                          height: MediaQuery.of(context).size.height * 0.68,
                          child: Center(
                              child: Text(
                            "Your scans will be listed here.",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                        ),
                      if (control.count.value != 0)
                        Container(
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: ListView.builder(
                            itemCount: control.count.value,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  control.noteList[index].saveResult,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                subtitle: Text(
                                    control.noteList[index].date.toString()),
                                trailing: InkWell(
                                  onTap: () {
                                    _delete(context, control.noteList[index]);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    child: Icon(Icons.delete),
                                  ),
                                ),
                                onLongPress: () {
                                  print("onLongPress");
                                },
                                onTap: () {
                                  _navigateToDetail(control.noteList[index]);
                                },
                              );
                            },
                          ),
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

  void _delete(BuildContext context, Databasedata databasedata) async {
    var delete = await control.helper.deleteNote(databasedata.id);
    if (delete != 0) {
      control.updateListView();
      Get.snackbar('Successfully', '1 entry Deleted.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          duration: Duration(milliseconds: 1000),
          margin: EdgeInsets.all(10));
    }
  }

  void _navigateToDetail(Databasedata databasedata) async {
    bool result = await Get.to(() => HistoryBrief(databasedata));
    if (result == null) {
      control.updateListView();
    } else {
      control.updateListView();
    }
  }
}
