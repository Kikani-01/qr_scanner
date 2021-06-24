import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scann/DataBase/databasehelper.dart';
import 'package:qr_scann/DataBase/getdata.dart';
import 'package:share/share.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationCreate extends StatefulWidget {
  @override
  _LocationCreateState createState() => _LocationCreateState();
}

class _LocationCreateState extends State<LocationCreate> {
  int isFavourite = 1;
  final TextEditingController _textController = TextEditingController();
  var date = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());

  GlobalKey globalKey = new GlobalKey();

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position currentPosition;
  String currentAddress;

  getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        getAddressFromLatLng();
        print(currentPosition);
      });
    }).catchError((e) {
      print(e);
    });
  }

  getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        currentAddress =
            "${place.name}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}";
      });
    } catch (e) {
      print(e);
    }
  }

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print("Could not launch $command ");
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  MenuOption select;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Location",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  screenShotAndShare();
                });
          }),
          SizedBox(
            width: 10,
          ),
          popMenu(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentPosition != null && currentAddress != null)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: RepaintBoundary(
                  key: globalKey,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SfBarcodeGenerator(
                          value: currentAddress,
                          symbology: QRCode(),
                          showValue: false,
                          barColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (currentPosition != null && currentAddress != null)
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  currentAddress,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Your current Location',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                date,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget popMenu() {
    return PopupMenuButton<MenuOption>(
      onSelected: (MenuOption result) {
        select = result;
        switch (select) {
          case MenuOption.Favorites:
            {
              // favourite();
            }
            break;

          case MenuOption.Copy:
            {
              copyClipboard();
            }
            break;
        }
      },
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      itemBuilder: (context) => <PopupMenuEntry<MenuOption>>[
        PopupMenuItem(
          child: Text("Favorites"),
          value: MenuOption.Favorites,
        ),
        PopupMenuItem(
          child: Text("Copy Code"),
          value: MenuOption.Copy,
        )
      ],
    );
  }

  void copyClipboard() {
    Get.snackbar("Copied", "Copied to clipboard",
        margin: EdgeInsets.all(10), snackPosition: SnackPosition.BOTTOM);
    Clipboard.setData(new ClipboardData(text: currentAddress));
  }

  void save() async {
    DatabaseHelper helper = DatabaseHelper();
    Databasedata databasedata = Databasedata();
    databasedata.saveResult = currentAddress.toString();
    databasedata.date = date.toString();
    databasedata.isFavourite = 1;
    var save;
    if (databasedata.id != null) {
      save = await helper.updateNote(databasedata);
    } else {
      save = await helper.insertNote(databasedata);
    }
  }

  Future<Null> screenShotAndShare() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      if (boundary.debugNeedsPaint) {
        Timer(Duration(seconds: 1), () => screenShotAndShare());
        return null;
      }
      final image = await boundary.toImage();
      final directory = (await getExternalStorageDirectory()).path;
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final imgFile = File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      final RenderBox box = context.findRenderObject();
      Share.shareFiles([imgFile.path],
          text: currentAddress,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } on PlatformException catch (e) {
      print("Exception while taking screenshot:" + e.toString());
    }
  }
}

enum MenuOption {
  Favorites,
  Copy,
}
