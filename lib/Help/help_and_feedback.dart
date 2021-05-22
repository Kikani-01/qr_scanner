import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scann/Help/scanning_not_work.dart';
import 'package:qr_scann/Help/supported_codes.dart';
import 'package:qr_scann/Help/tips_for_scanning.dart';
import 'package:url_launcher/url_launcher.dart';

import 'faq.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Help & Feedback",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            title: Text("Supported codes"),
            onTap: () {
              Get.to(SupportedCodes());
            },
          ),
          ListTile(
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Icon(
                  Icons.lightbulb_outline,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            title: Text("Tips for scanning"),
            onTap: () {
              Get.to(TipForScanning());
            },
          ),
          ListTile(
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            title: Text("'Scanning does not work!'"),
            onTap: () {
              Get.to(ScanningNotWork());
            },
          ),
          ListTile(
            leading: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Icon(
                  Icons.messenger,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            title: Text("FAQ"),
            onTap: () {
              Get.to(FAQ());
            },
          ),
          ListTile(
              leading: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Icon(Icons.mail, color: Colors.white, size: 20),
                ),
              ),
              title: Text("Send us an email"),
              onTap: () {
                Get.defaultDialog(
                  content: Container(
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Many Questions are already answered in the 'FAQ'.\n"),
                        Text("Please write your email in English\n"),
                        Text(
                            "if Possible, please include photos of the barcode or screenshots."),
                      ],
                    ),
                  ),
                  title: "Send E-Mail",
                  textCancel: "CANCEL",
                  onCancel: () {
                    Get.back();
                  },
                  textConfirm: "OK",
                  onConfirm: () {
                    SendEmail.openEmail(
                      toEmail: "android@qrbot.net",
                      subject: "Feedback regarding QR Scanner",
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}

class SendEmail {
  static Future _launcher(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
    ;
  }

  static openEmail({
    @required String toEmail,
    @required String subject,
  }) async {
    final url = "mailto:$toEmail?subject=${Uri.encodeFull(subject)}";
    await _launcher(url);
  }
}
