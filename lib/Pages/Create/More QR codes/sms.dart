import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_scann/Screen/Create/create_all_result.dart';

class SMS extends StatelessWidget {
  var _key = GlobalKey<FormState>();
  var result;
  var type = "SMS";
  var date = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
  TextEditingController phone = TextEditingController();
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
              this.result = phoneString();
              if (_key.currentState.validate()) {
                Get.to(CreateAllResult(result, type, date));
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

  phoneString() {
    String email = this.phone.text.toString();
    String message = this.message.text.toString();

    return '''$email
$message
    ''';
  }
}
