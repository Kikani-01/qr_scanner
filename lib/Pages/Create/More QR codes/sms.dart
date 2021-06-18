import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scann/Pages/Create/Barcodes%20and%20other%202D%20codes/create_all_barcode.dart';

class SMS extends StatelessWidget {
  var _key = GlobalKey<FormState>();
  var result;
  TextEditingController phone = TextEditingController();
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "SMS",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (_key.currentState.validate()) {
                Get.to(CreateAllBarcodes(
                    "${phone.text.toString()} ${message.text.toString()}",
                    "SMS",
                    "QR Code"));
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _key,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextFormField(
                cursorColor: Colors.orange,
                controller: phone,
                validator: (value) =>
                    value.isEmpty ? "Please enter phone Number" : null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Phone number",
                  border: InputBorder.none,
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextFormField(
                cursorColor: Colors.orange,
                controller: message,
                validator: (value) =>
                    value.isEmpty ? "Please enter your message." : null,
                decoration: InputDecoration(
                  hintText: "Message",
                  border: InputBorder.none,
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
