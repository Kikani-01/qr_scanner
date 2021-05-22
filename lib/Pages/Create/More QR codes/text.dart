import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_scann/Screen/Create/create_all_result.dart';

class TextQR extends StatelessWidget {
  var _key = GlobalKey<FormState>();
  TextEditingController result = TextEditingController();
  var save = '';
  var type = "Text";
  var date = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          type,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              save = result.text.toString();
              if (_key.currentState.validate()) {
                Get.to(CreateAllResult(save, type, date));
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: TextFormField(
                cursorColor: Colors.orange,
                controller: result,
                validator: (value) =>
                    value.isEmpty ? "Please enter text" : null,
                decoration: InputDecoration(
                  hintText: "Text",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
