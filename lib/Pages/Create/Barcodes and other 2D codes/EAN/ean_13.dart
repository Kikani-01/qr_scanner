import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../create_all_barcode.dart';

class EAN13Code extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  var _globalKey = GlobalKey<FormState>();
  var result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "EAN 13",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                this.result.value = controller.text;
                if (_globalKey.currentState.validate()) {
                  Get.to(CreateAllBarcodes(result, "EAN 13", "EAN"));
                }
              })
        ],
      ),
      body: Form(
        key: _globalKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: controller,
                validator: (value) => value.isEmpty ? "Required" : null,
                decoration: InputDecoration(
                  hintText: "12 digits + 1 checksum digit",
                  border: InputBorder.none,
                  counter: Offstage(),
                ),
                keyboardType: TextInputType.number,
                maxLength: 12,
                cursorColor: Colors.orange,
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
