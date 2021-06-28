import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scann/DataBase/databasehelper.dart';
import 'package:qr_scann/DataBase/getdata.dart';
import 'package:qr_scann/Pages/Create/Barcodes%20and%20other%202D%20codes/Code/code_bar.dart';
import 'package:share/share.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateAllResult extends StatelessWidget {
  var result;
  final String type;
  final String category;
  CreateAllResult(this.result, this.type, this.category);
  DatabaseHelper helper = DatabaseHelper();
  Databasedata databasedata = Databasedata();
  RxBool favourite = true.obs;

  var add = "Add to favourites".obs;

  var date = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());

  checkType(String test) {
    switch (test) {
      case "Qr code":
        {
          return QRCode();
        }
        break;
      case "code 39":
        {
          return Code39();
        }
        break;
      case "code 93":
        {
          return Code93();
        }
        break;
      case "code 128":
        {
          return Code128();
        }
        break;
      case "code bar":
        {
          return CODEBar();
        }
        break;
      case "Data matrix":
        {
          return DataMatrix();
        }
        break;
      case "EAN 8":
        {
          return EAN8();
        }
        break;
      case "EAN 13":
        {
          return EAN13();
        }
        break;
      case "code bar":
        {
          return CODEBar();
        }
        break;
      case "Contact":
        {
          return QRCode();
        }
        break;

      default:
        {
          return QRCode();
        }
        break;
    }
  }

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print("Could not launch $command ");
    }
  }

  GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            category,
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    screenShotAndShare(context);
                  });
            }),
            SizedBox(
              width: 10,
            ),
            popMenu(databasedata),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          value: result,
                          symbology: checkType(type),
                          showValue: false,
                          barColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  child: Text(
                    result,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    customLaunch(result);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  bottom: 20.0,
                ),
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  MenuOption select;
  favoriteChange(Databasedata databasedata) async {
    var save;
    if (databasedata.isFavourite == 1) {
      databasedata.isFavourite = 2;
      save = await helper.updateNote(databasedata);
      add.value = "Remove from favourites";
      favourite.value = false;
    } else {
      databasedata.isFavourite = 1;
      save = await helper.updateNote(databasedata);
      add.value = "Add to favourites";
      favourite.value = true;
    }
  }

  Widget popMenu(databasedata) {
    return PopupMenuButton<MenuOption>(
      onSelected: (MenuOption result) {
        select = result;
        switch (select) {
          case MenuOption.Favorites:
            {
              favoriteChange(databasedata);
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
          child: Obx(() => Text(add.value)),
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
    Clipboard.setData(new ClipboardData(text: result));
  }

  Future<Null> screenShotAndShare(context) async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      if (boundary.debugNeedsPaint) {
        Timer(Duration(seconds: 1), () => screenShotAndShare(context));
        return null;
      }
      final image = await boundary.toImage();
      final directory = (await getExternalStorageDirectory()).path;
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      File imgFile = new File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      final RenderBox box = context.findRenderObject();
      Share.shareFiles([imgFile.path],
          text: result,
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
