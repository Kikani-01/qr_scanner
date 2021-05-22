import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'file:///C:/Users/MANSI%20KIKANI/Desktop/QR_scaner/QR%20Scanner/lib/Screen/Create/create_all_result.dart';

class EmailQR extends StatelessWidget {
  var _key = GlobalKey<FormState>();
  var result;
  var date = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
  var type = "Email";
  TextEditingController email = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();

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
              this.result = emailString();
              if (_key.currentState.validate()) {
                Get.to(CreateAllResult(result, type, date));
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

  emailString() {
    String email = this.email.text.toString();
    String subject = this.subject.text.toString();
    String message = this.message.text.toString();

    return '''$email
$subject
$message
    ''';
  }
}
