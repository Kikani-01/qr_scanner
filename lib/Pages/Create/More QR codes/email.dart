import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_scann/Pages/Create/Barcodes%20and%20other%202D%20codes/create_all_barcode.dart';

class EmailQR extends StatelessWidget {
  var _key = GlobalKey<FormState>();
  var result;
  var date = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
  TextEditingController email = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Email",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (_key.currentState.validate()) {
                Get.to(CreateAllBarcodes(
                    "${email.text.toString()}\n"
                        "${subject.text.toString()}\n"
                        "${message.text.toString()}",
                    "Email",
                    "QR Code"));
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  cursorColor: Colors.orange,
                  controller: email,
                  validator: (value) =>
                      value.isEmpty ? "Please enter email" : null,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  cursorColor: Colors.orange,
                  controller: subject,
                  decoration: InputDecoration(
                    hintText: "Subject",
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
            ],
          ),
        ),
      ),
    );
  }
}
