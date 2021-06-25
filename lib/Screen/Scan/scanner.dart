import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scann/Controller/result_qr_code.dart';
import 'package:qr_scann/Help/help_and_feedback.dart';
import 'package:qr_scann/Pages/Ads/add.dart';

class Scanner extends StatelessWidget {
  RxBool light = true.obs;
  final control = Get.put(ScanController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height > 500
        ? MediaQuery.of(context).size.height * 0.11
        : MediaQuery.of(context).size.height * 0.1;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height,
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Column(
                        children: [
                          Obx(
                            () => light.value
                                ? Icon(
                                    Icons.lightbulb_outline,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.lightbulb,
                                    color: Colors.white,
                                  ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Light",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onTap: () async {
                        await control.controller?.toggleFlash();
                        light.value = !light.value;
                      },
                    ),
                    InkWell(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Scan Image",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onTap: control.getPhotoByGallery,
                    ),
                    InkWell(
                      child: Column(
                        children: [
                          Icon(
                            Icons.help,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Help",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Get.to(Help());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          GetBuilder<ScanController>(
            initState: (data) => control.initPlayer,
            builder: (builder) => Expanded(
              flex: 5,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.65,
                child: control.buildQrView(context),
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
