import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scann/Controller/customSearchAndEdit_controller.dart';
import 'package:qr_scann/DataBase/CustomSearch/custom_databasehelper.dart';
import 'package:qr_scann/DataBase/CustomSearch/custom_search_data.dart';

class CustomSearchAndEdit extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController label = TextEditingController();
  TextEditingController url = TextEditingController();

  RxString _selectedItems = 'All'.obs;
  List<String> items = ['Products', 'Products and text', 'All'].obs;

  CustomDataHelper customDataHelper = CustomDataHelper();
  CustomSearchData customSearchData = CustomSearchData();
  CustomSearchAndEdit(this.customSearchData);

  final control = Get.put(CustomSearchAndEditController());
  @override
  Widget build(BuildContext context) {
    label.text = customSearchData.title;
    url.text = customSearchData.webSite;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            label.text.toString(),
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  delete(context);
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: GetBuilder<CustomSearchAndEditController>(
              initState: (data) => control.executeSetValue(),
              builder: (builder) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextFormField(
                      cursorColor: Colors.orange,
                      controller: label,
                      decoration: InputDecoration(
                        hintText: "Label",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 18),
                      ),
                      onChanged: (value) {
                        updateTitle();
                      },
                    ),
                  ),
                  Divider(
                    height: 3,
                    thickness: 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: TextFormField(
                      cursorColor: Colors.orange,
                      controller: url,
                      decoration: InputDecoration(
                        hintText: "URL",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 18),
                      ),
                      onChanged: (value) {
                        updateWebSite();
                      },
                    ),
                  ),
                  Divider(
                    height: 3,
                    thickness: 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, top: 12.0, bottom: 12.0),
                    child: Text(
                        "Determine the URL by inserting the placeholder {code} where the barcode should be inserted.\nExample: https://google.com/search?q={code}"),
                  ),
                  Divider(
                    height: 3,
                    thickness: 1.5,
                  ),
                  ListTile(
                    title: Text("Execute automatically"),
                    trailing: Obx(
                      () => Switch(
                          value: control.execute.value,
                          activeColor: Colors.orange,
                          onChanged: (value) {
                            control.execute.value = value;
                          }),
                    ),
                  ),
                  Divider(
                    height: 3,
                    thickness: 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, top: 12.0, bottom: 12.0),
                    child: Text("Activation mode"),
                  ),
                  Divider(
                    height: 3,
                    thickness: 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Obx(
                          () => DropdownButton<String>(
                            value: _selectedItems.value,
                            onChanged: (String newValue) {
                              _selectedItems.value = newValue;
                            },
                            items: items.map((String itemsString) {
                              return DropdownMenuItem<String>(
                                child: Text(itemsString),
                                value: itemsString,
                              );
                            }).toList(),
                            // dropdownColor: Colors.grey.shade900,
                            icon: Icon(
                              Icons.arrow_drop_down_sharp,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            save();
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.cyan,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

/*  movetoLastScreen() {
    Get.back(canPop: true);
  }*/

  updateTitle() {
    customSearchData.title = label.text;
  }

  updateWebSite() {
    customSearchData.webSite = url.text;
  }

  void delete(BuildContext context) async {
    await customDataHelper.deleteNote(customSearchData.id);
    Get.back(canPop: true);
  }

  void save() async {
    var result;
    if (customSearchData.id != null) {
      result = await customDataHelper.updateNote(customSearchData);
    } else {
      result = await customDataHelper.insertNote(customSearchData);
    }
    Get.back(canPop: true);
  }
}
