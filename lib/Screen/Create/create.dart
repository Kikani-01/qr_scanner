import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_scann/Pages/Ads/add.dart';
import 'package:qr_scann/Pages/Create/Barcodes%20and%20other%202D%20codes/barcodes_and_other_2d_codes.dart';
import 'package:qr_scann/Pages/Create/Contact/contact.dart';
import 'package:qr_scann/Pages/Create/Event/event.dart';
import 'package:qr_scann/Pages/Create/Location/location.dart';
import 'package:qr_scann/Pages/Create/More%20QR%20codes/more_qr_codes.dart';
import 'package:qr_scann/Pages/Create/WI-FI/wifi.dart';
import 'package:qr_scann/Pages/Create/Website/website.dart';
import 'package:qr_scann/Screen/Create/share.dart';

import 'create_all_result.dart';

class Create extends StatelessWidget {
  var textValue;
  var type = "Content from clipboard";
  var date = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
  void _getClipboard() async {
    ClipboardData data = await Clipboard.getData(Clipboard.kTextPlain);
    textValue = data.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //ShareExmaple
                    ListTile(
                      leading: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.grey,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 20,
                            ),
                          )),
                      title: Text("Use SHARE in in other apps"),
                      onTap: () {
                        Get.to(ShareExmaple());
                      },
                    ),
                    //clipboard
                    ListTile(
                      leading: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.orange,
                          ),
                          child: Icon(
                            Icons.copy,
                            color: Colors.white,
                            size: 20,
                          )),
                      title: Text("Content from clipboard"),
                      onTap: () {
                        _getClipboard();
                        Get.to(CreateAllResult(textValue, type, date));
                      },
                    ),
                    //WebSite
                    ListTile(
                      leading: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.orange,
                          ),
                          child: Icon(
                            Icons.language,
                            color: Colors.white,
                            size: 20,
                          )),
                      title: Text("website"),
                      onTap: () {
                        Get.to(WebSite());
                      },
                    ),
                    //Contact
                    ListTile(
                      leading: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.orange,
                          ),
                          child: Icon(
                            Icons.person_add,
                            color: Colors.white,
                            size: 20,
                          )),
                      title: Text("Contact"),
                      onTap: () {
                        Get.to(Contact());
                      },
                    ),
                    //WiFi
                    ListTile(
                      leading: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.orange,
                          ),
                          child: Icon(
                            Icons.wifi,
                            color: Colors.white,
                            size: 20,
                          )),
                      title: Text("Wi-Fi"),
                      onTap: () {
                        Get.to(WiFi());
                      },
                    ),
                    //LocationCreate
                    ListTile(
                      leading: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.orange,
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 20,
                          )),
                      title: Text("Location"),
                      onTap: () {
                        //  Give it a try
                        Get.to(LocationCreate());
                      },
                    ),
                    //Event
                    ListTile(
                      leading: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.orange,
                          ),
                          child: Icon(
                            Icons.event,
                            color: Colors.white,
                            size: 20,
                          )),
                      title: Text("Calender"),
                      onTap: () {
                        //  Give it a try
                        Get.to(Event());
                      },
                    ),
                    //MoreQRCodes
                    ListTile(
                      leading: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.cyan,
                          ),
                          child: Icon(
                            Icons.qr_code_rounded,
                            color: Colors.white,
                            size: 20,
                          )),
                      title: Text("More QR codes"),
                      onTap: () {
                        Get.to(MoreQRCodes());
                      },
                    ),
                    //Barcodes and other 2D codes
                    ListTile(
                      leading: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.cyan,
                          ),
                          child: Icon(
                            Icons.qr_code_scanner,
                            color: Colors.white,
                            size: 20,
                          )),
                      title: Text("Barcodes and other 2D codes"),
                      onTap: () {
                        Get.to(BarcodesAnd2DCodes());
                      },
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => Get.to(Ads()),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                color: Colors.cyan,
                child: Column(
                  children: [
                    Text("Remove Ads"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
