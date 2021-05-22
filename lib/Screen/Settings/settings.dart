import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qr_scann/Controller/settings_controller.dart';
import 'package:qr_scann/Help/help_and_feedback.dart';
import 'package:qr_scann/Layout/responsive_layout.dart';
import 'package:qr_scann/Pages/Ads/add.dart';
import 'package:qr_scann/Pages/Custom%20Search/custom_search_options.dart';
import 'package:qr_scann/Pages/ScanProduct/scan_product.dart';
import 'package:qr_scann/ThemeProvider/theme.dart';

class Settings extends StatelessWidget {
  final controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    themeProvider.getTheme;
    print("Settings");
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: GetBuilder<SettingsController>(
                  builder: (builder) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(Ads());
                        },
                        child: Card(
                          child: ResponsiveLayout(
                            mobile: ListTile(
                              leading: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.cyan,
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.dollarSign,
                                    size: 18,
                                    color: Colors.white,
                                  )),
                              title: Text(
                                "No Advertising",
                                style: TextStyle(fontSize: 15),
                              ),
                              subtitle: Text("Pro version"),
                              trailing: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.orange,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 18,
                                    color: Colors.white,
                                  )),
                            ),
                            tab: ListTile(
                              leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.cyan,
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.dollarSign,
                                    size: 20,
                                    color: Colors.white,
                                  )),
                              title: Text("No Advertising"),
                              subtitle: Text("Pro version"),
                              trailing: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.orange,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Text(
                          "Product barcods",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.brightness_medium_sharp),
                        title: Text("Theme"),
                        subtitle: Text(controller.selectedTheme.value),
                        onTap: () {
                          controller.themeChangeDialog(themeProvider);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.help),
                        title: Text("Help & Feedback"),
                        onTap: () {
                          Get.to(Help());
                        },
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 50.0, top: 20, bottom: 10),
                        child: Text(
                          "Scan Controls",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.unarchive_outlined),
                        title: Text("Open websites automatically"),
                        subtitle: Text("System Default"),
                        trailing: Obx(
                          () => Switch(
                            value: controller.openWebsite.value,
                            activeColor: Colors.orange,
                            onChanged: (value) async {
                              controller.openWebsite.value = value;
                              controller.saveInSharedPref();
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.forward),
                        title: Text("Continuous scanning"),
                        subtitle: Text("Add scans history only"),
                        trailing: Obx(
                          () => Switch(
                            value: controller.continuous.value,
                            activeColor: Colors.orange,
                            onChanged: (value) {
                              controller.continuous.value = value;
                              controller.saveInSharedPref();
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.filter_list),
                        title: Text("Duplicate barcodes"),
                        subtitle: Text("Store duplicate barcodes in history"),
                        trailing: Obx(
                          () => Switch(
                            value: controller.duplicate.value,
                            activeColor: Colors.orange,
                            onChanged: (value) {
                              controller.duplicate.value = value;
                              controller.saveInSharedPref();
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.check),
                        title: Text("Confirm scans manually"),
                        subtitle: Text("Avoid accidetnal scans"),
                        trailing: Obx(
                          () => Switch(
                            value: controller.confirm.value,
                            activeColor: Colors.orange,
                            onChanged: (value) {
                              controller.confirm.value = value;
                              controller.saveInSharedPref();
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.volume_up_sharp),
                        title: Text("Play sound"),
                        trailing: Obx(
                          () => Switch(
                            value: controller.sound.value,
                            activeColor: Colors.orange,
                            onChanged: (value) async {
                              controller.sound.value = value;
                              controller.saveInSharedPref();
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.vibration_sharp),
                        title: Text("Vibrate"),
                        trailing: Obx(
                          () => Switch(
                            value: controller.vibrate.value,
                            activeColor: Colors.orange,
                            onChanged: (value) =>
                                controller.toggleVibrate(value),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.copy),
                        title: Text("Copy to clipboard"),
                        trailing: Obx(
                          () => Switch(
                            value: controller.copy.value,
                            activeColor: Colors.orange,
                            onChanged: (value) {
                              controller.copy.value = value;
                              controller.saveInSharedPref();
                            },
                          ),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 50, top: 20, bottom: 10),
                        child: Text(
                          "Product barcods",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: ListTile(
                          title: Text("Country for product search"),
                          subtitle: Text("Automatic"),
                          onTap: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: ListTile(
                          title: Text("Product information"),
                          subtitle: Text(
                              "Display product and pricing information automatically , if available"),
                          trailing: Obx(() => Switch(
                                value: controller.productsInformation.value,
                                activeColor: Colors.orange,
                                onChanged: (value) {
                                  controller.productsInformation.value = value;
                                  controller.saveInSharedPref();
                                },
                              )),
                          onTap: () {},
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 50.0, top: 20, bottom: 10),
                        child: Text(
                          "Advance Settings",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: ListTile(
                          title: Text("Costom Search options"),
                          subtitle: Text(
                              "URLs that can be executed automatically when scanning a code."),
                          onTap: () {
                            Get.to(CustomSearchOption());
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: ListTile(
                          title: Text("Camera"),
                          subtitle: Text("Camera 1(Recommended)"),
                          onTap: () {
                            controller.changeCamera();
                          },
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 50.0, top: 20, bottom: 10),
                        child: Text(
                          "Privacy",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: ListTile(
                          title: Text("Privacy policy"),
                          onTap: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: ListTile(
                          title: Text("Usage Statistics"),
                          subtitle: Text(
                              "Send anonymous usage statistics to improve the app "),
                          trailing: Obx(
                            () => Switch(
                              value: controller.usageStatistics.value,
                              activeColor: Colors.orange,
                              onChanged: (value) {
                                controller.usageStatistics.value = value;
                                controller.saveInSharedPref();
                              },
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 50.0, top: 20, bottom: 10),
                        child: Text(
                          "About",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: ListTile(
                          title: Text("Introduction"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScanProduct()));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: ListTile(
                          title: Text("Open-source licences"),
                          onTap: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: ListTile(
                          title: Text("App version"),
                          subtitle: Text(controller.packageInfo.version),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
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

class ScanControls {
  String title;
  String subTitles;
  IconData iconData;
  bool value;

  ScanControls(
      {@required this.title,
      this.subTitles,
      this.iconData,
      this.value = false});
}
