import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scann/Controller/custom_search_option_controller.dart';
import 'package:qr_scann/DataBase/CustomSearch/custom_search_data.dart';

import 'custom_add_and_edit.dart';

class CustomSearchOption extends StatelessWidget {
  final customSearchDataController = Get.put(CustomSearchOptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          "Custom Search Options",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: GetBuilder<CustomSearchOptionController>(
        init: customSearchDataController.updateListView(),
        builder: (value) => Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                if (customSearchDataController.count.value == 0)
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
                        child: Text(
                      "Create Custom Search",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
                  ),
                if (customSearchDataController.count.value != 0)
                  Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: ListView.builder(
                          itemCount: customSearchDataController.count.value,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.orange,
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(customSearchDataController
                                  .customDataList[index].title),
                              subtitle: Text(customSearchDataController
                                  .customDataList[index].webSite),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  delete(
                                      context,
                                      customSearchDataController
                                          .customDataList[index]);
                                },
                              ),
                              onTap: () {
                                navigateToDetails(
                                    context,
                                    customSearchDataController
                                        .customDataList[index]);
                              },
                            );
                          })),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          navigateToDetails(context, CustomSearchData(title: "", webSite: ""));
        },
        backgroundColor: Colors.cyan,
      ),
    );
  }

  void delete(BuildContext context, CustomSearchData customSearchData) async {
    var result = await customSearchDataController.customDataHelper
        .deleteNote(customSearchData.id);
    if (result != null) {
      Get.snackbar('Successfully', '1 entry Deleted.',
          snackPosition: SnackPosition.BOTTOM,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          duration: Duration(milliseconds: 1000),
          margin: EdgeInsets.all(15));
      customSearchDataController.updateListView();
    }
  }

  void navigateToDetails(
      BuildContext context, CustomSearchData customSearchData) async {
    final check = await Get.to(() => CustomSearchAndEdit(customSearchData));
    if (check == null) {
      customSearchDataController.updateListView();
    } else {
      customSearchDataController.updateListView();
    }
  }
}
