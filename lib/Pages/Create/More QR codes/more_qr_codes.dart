import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'email.dart';
import 'sms.dart';
import 'text.dart';

class MoreQRCodes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "More QR codes",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.orange,
                ),
                child: Center(
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                "Text",
              ),
              onTap: () {
                Get.to(TextQR());
              },
            ),
            ListTile(
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.orange,
                ),
                child: Center(
                  child: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                "Email",
              ),
              onTap: () {
                Get.to(EmailQR());
              },
            ),
            ListTile(
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.orange,
                ),
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                "SMS",
              ),
              onTap: () {
                Get.to(SMS());
              },
            ),
            ListTile(
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.orange,
                ),
                child: Center(
                  child: Icon(
                    Icons.apps,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                "App",
              ),
              onTap: () {
                Get.to(ListAppsPages());
              },
            ),
          ],
        ),
      ),
    );
  }
}
