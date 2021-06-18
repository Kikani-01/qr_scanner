import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../create_all_barcode.dart';

class CODE39 extends StatelessWidget {
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
          "Code 39",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                this.result = controller.text.toUpperCase();
                if (_globalKey.currentState.validate()) {
                  Get.to(CreateAllBarcodes(result, "code 39", "code"));
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
                decoration: InputDecoration(
                  hintText: "text in upper case without special characters",
                  border: InputBorder.none,
                ),
                cursorColor: Colors.orange,
                validator: (value) => value.isEmpty ? "Required" : null,
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
