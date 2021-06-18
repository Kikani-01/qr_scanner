import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../create_all_barcode.dart';

class DataMatrixCode extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  var globalKey = new GlobalKey<FormState>();
  var result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Data matrix",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                this.result = controller.text;
                if (globalKey.currentState.validate()) {
                  Get.to(
                      CreateAllBarcodes(result, "Data matrix", "Data matrix"));
                }
              })
        ],
      ),
      body: Form(
        key: globalKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "text without special characters",
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
