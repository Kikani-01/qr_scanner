import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../create_all_barcode.dart';

class UPCACode extends StatelessWidget {
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
          "UPC A",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                this.result = controller.text;
                if (_globalKey.currentState.validate()) {
                  Get.to(CreateAllBarcodes(result, "UPC A", "UPC"));
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
                  hintText: "11 digits + 1 checksum digit",
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
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
