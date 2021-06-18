import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scann/Pages/Create/Barcodes%20and%20other%202D%20codes/create_all_barcode.dart';

class ListAppsPages extends StatelessWidget {
  bool _showSystemApps = true;
  bool _onlyLaunchableApps = true;
  var result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Installed applications',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListAppsPagesContent(
          includeSystemApps: _showSystemApps,
          onlyAppsWithLaunchIntent: _onlyLaunchableApps,
          key: GlobalKey()),
    );
  }
}

class ListAppsPagesContent extends StatelessWidget {
  final bool includeSystemApps;
  final bool onlyAppsWithLaunchIntent;

  ListAppsPagesContent(
      {Key key,
      this.includeSystemApps: false,
      this.onlyAppsWithLaunchIntent: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Application>>(
        future: DeviceApps.getInstalledApplications(
            includeAppIcons: true,
            includeSystemApps: includeSystemApps,
            onlyAppsWithLaunchIntent: onlyAppsWithLaunchIntent),
        builder: (BuildContext context, AsyncSnapshot<List<Application>> data) {
          if (data.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<Application> apps = data.data;
            return Scrollbar(
              child: ListView.builder(
                  itemBuilder: (BuildContext context, int position) {
                    Application app = apps[position];
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: app is ApplicationWithIcon
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(app.icon),
                                  backgroundColor: Colors.white,
                                )
                              : null,
                          onTap: () {
                            Get.to(CreateAllBarcodes(
                                "https://play.google.com/store/apps/details?id=${app.packageName}",
                                "Apps",
                                "QR Code"));
                          },
                          title: Text('${app.appName}'),
                        ),
                        Divider(
                          height: 1.0,
                        )
                      ],
                    );
                  },
                  itemCount: apps.length),
            );
          }
        });
  }
}
