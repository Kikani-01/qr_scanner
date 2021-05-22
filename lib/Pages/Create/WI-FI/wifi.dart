import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_scann/Screen/Create/create_all_result.dart';

class WiFi extends StatelessWidget {
  TextEditingController networkName = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController password = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  var type = ['WPA/WPA2', 'WEP', '_'];
  var result;
  var current = 'WPA/WPA2'.obs;
  var typey = "Wi-Fi";
  var date = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          typey,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              this.result = contactString();
              if (_globalKey.currentState.validate()) {
                Get.to(CreateAllResult(
                  result,
                  typey,
                  date,
                ));
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _globalKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 10.0,
                ),
                child: TextFormField(
                  controller: networkName,
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    hintText: "Network name",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  validator: (value) =>
                      value.isEmpty ? "Please enter network name" : null,
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Obx(
                  () => DropdownButton<String>(
                    value: current.value,
                    onChanged: (String newValue) {
                      current.value = newValue;
                    },
                    items: type.map((String itemsString) {
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
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: TextFormField(
                  controller: password,
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: InputBorder.none,
                    counterText: "",
                  ),
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  validator: (value) => value.length < 8
                      ? value.isEmpty
                          ? "Please enter password"
                          : "password to short"
                      : null,
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  contactString() {
    String firstName = this.networkName.text.toString();
    String lastName = this.password.text.toString();

    return '''
  $firstName
  $current
  $lastName
   ''';
  }
}
