import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scann/DataBase/databasehelper.dart';
import 'package:qr_scann/DataBase/getdata.dart';
import 'package:qr_scann/Pages/ResultQR/result_qr_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class ScanController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initPlayer();
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

  void settingsData() async {
    SharedPreferences value = await SharedPreferences.getInstance();

    final soundpref = value.getBool("sound");
    if (soundpref == null) {
      sound.value = true;
    } else {
      sound.value = soundpref;
    }

    final vibratepref = value.getBool("vibrate");
    if (vibratepref == null) {
      vibrate.value = true;
    } else {
      vibrate.value = vibratepref;
    }

    final copypref = value.getBool("copy");
    if (copypref == null) {
      copy.value = true;
    } else {
      copy.value = copypref;
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
    update();
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
        _save();
      }
      type = scanData.format.toString();

      if (sound.value) {
        audioCache.play("music/beep_Trim.mp4");
      }
      if (vibrate.value) {
        Vibration.vibrate();
      }
      if (copy.value) {
        Clipboard.setData(new ClipboardData(text: result));
      }

      final data = await Get.to(() => ResultQRPage(result, type, date));

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
  void _save() async {
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
