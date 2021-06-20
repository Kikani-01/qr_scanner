import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:qr_scann/DataBase/databasehelper.dart';
import 'package:qr_scann/DataBase/getdata.dart';
import 'package:qr_scann/Pages/ResultQR/result_qr_page.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

class ScanController extends GetxController {
  final picker = ImagePicker();
  var qrcodeFile;
  var data;

  @override
  void onInit() {
    super.onInit();
    initPlayer();
    Stream.fromFuture(getTemporaryDirectory())
        .flatMap((tempDir) {
          File qrCodeFile = File('${tempDir.path}/help1.jpg');
          bool exists = qrCodeFile.existsSync();
          if (exists) {
            return Stream.value(qrCodeFile);
          } else {
            return Stream.fromFuture(rootBundle.load("assets/help1.jpg"))
                .flatMap((bytes) => Stream.fromFuture(qrCodeFile.writeAsBytes(
                    bytes.buffer.asUint8List(
                        bytes.offsetInBytes, bytes.lengthInBytes))));
          }
        })
        .flatMap((file) =>
            Stream.fromFuture(QrCodeToolsPlugin.decodeFrom(file.path)))
        .listen((data) {
          this.data = data;
          update();
        });
  }

  void getPhotoByGallery() {
    Stream.fromFuture(picker.getImage(source: ImageSource.gallery))
        .flatMap((file) {
      qrcodeFile = file.path;
      return Stream.fromFuture(QrCodeToolsPlugin.decodeFrom(file.path));
    }).listen((data) {
      this.data = data;
      update();
    }).onError((error, stackTrace) {
      print('++ ${error.toString()}');
      Get.back();
      Get.snackbar(
        "Code not Found",
        "Crop the code from the photos then try.",
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.black,
        margin: EdgeInsets.all(10),
      );
    });
    if (data != null) {
      Get.to(() => ResultQRPage(data, "BarcodeFormat.QRCODE", date));
    } else {
      Get.back();
    }
  }

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print("Could not launch $command");
    }
  }

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;
  AudioCache audioCache;
  AudioPlayer advancedPlayer;

  void initPlayer() {
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
    settingsData();
  }

  RxBool sound = true.obs;
  RxBool vibrate = true.obs;
  RxBool copy = true.obs;
  RxBool continuous = false.obs;
  RxBool openWebSite = false.obs;
  RxBool duplicate = true.obs;

  void settingsData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final soundpref = pref.getBool("sound");
    if (soundpref == null) {
      sound.value = true;
    } else {
      sound.value = soundpref;
    }

    final vibratepref = pref.getBool("vibrate");
    if (vibratepref == null) {
      vibrate.value = true;
    } else {
      vibrate.value = vibratepref;
    }

    final copypref = pref.getBool("copy");
    if (copypref == null) {
      copy.value = true;
    } else {
      copy.value = copypref;
    }

    final continuouspref = pref.getBool("continuous");
    if (continuouspref == null) {
      continuous.value = false;
    } else {
      continuous.value = continuouspref;
    }

    final openWebsite = pref.getBool("openWebsite");
    if (openWebsite == null) {
      openWebSite.value = false;
    } else {
      openWebSite.value = openWebsite;
    }

    final duplicatePref = pref.getBool("openWebsite");
    if (duplicatePref == null) {
      duplicate.value = false;
    } else {
      duplicate.value = duplicatePref;
    }
    update();
  }

  RxDouble scanArea = 300.0.obs;
  CameraFacing camera = CameraFacing.back;

  changeCamera() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final soundpref = preferences.getString("ChangeCamera");
    if (soundpref == null) {
      camera = CameraFacing.back;
    } else if (soundpref == "Front Camera") {
      camera = CameraFacing.front;
    } else if (soundpref == "Back Camera") {
      camera = CameraFacing.back;
    }
  }

  buildQrView(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        changeCamera();
        if (orientation == Orientation.portrait) {
          scanArea.value = 300;
        } else {
          scanArea.value = 250;
        }
        return QRView(
          key: qrKey,
          onQRViewCreated: onQRViewCreated,
          cameraFacing: camera,
          overlay: QrScannerOverlayShape(
            borderColor: Colors.orange,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: scanArea.value,
          ),
        );
      },
    );
  }

  var result;
  var type;
  var date = DateFormat('dd-MM-yyyy kk:mm').format(DateTime.now()).toString();

  onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      settingsData();
      result = scanData.code;
      if (result != null) {
        await controller.pauseCamera();
      }
      type = scanData.format.toString();

      if (sound.value) {
        audioCache.play("music/beep_Trim.mp4");
      }
      if (vibrate.value) {
        Vibration.vibrate();
      }
      if (copy.value) {
        Clipboard.setData(ClipboardData(text: result));
      }
      var data;
      if (continuous.value == false) {
        if (openWebSite.value) {
          customLaunch(result);
        }
        data = await Get.to(() => ResultQRPage(result, type, date));
      } else {
        if (duplicate.value) {
          save();
        }
        controller.resumeCamera();
      }
      if (data == true) {
        controller.resumeCamera();
      } else if (data == null) {
        controller.pauseCamera();
      } else {
        controller.pauseCamera();
      }
    });
  }

  DatabaseHelper helper = DatabaseHelper();
  Databasedata databasedata = Databasedata();
  void save() async {
    databasedata.saveResult = result.toString();
    databasedata.date = date.toString();
    databasedata.isFavourite = 1;
    var save;
    if (databasedata.id != null) {
      save = await helper.updateNote(databasedata);
    } else {
      save = await helper.insertNote(databasedata);
    }
  }
}
