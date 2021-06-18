import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scann/Pages/Create/Barcodes%20and%20other%202D%20codes/create_all_barcode.dart';

class TextQR extends StatelessWidget {
  var _key = GlobalKey<FormState>();
  TextEditingController result = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Text",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (_key.currentState.validate()) {
                Get.to(CreateAllBarcodes(
                    result.text.toString(), "Text", "QR Code"));
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
