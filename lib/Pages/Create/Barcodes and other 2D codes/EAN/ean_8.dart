import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'file:///C:/Users/MANSI%20KIKANI/Desktop/QR_scaner/QR%20Scanner/lib/Pages/view_code.dart';
import 'package:share/share.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class EAN8Code extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  var _globalKey = GlobalKey<FormState>();
  var result = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "EAN 8",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                  this.result.value = controller.text;
                if (_globalKey.currentState.validate()) {
                  Get.to(_EAN8Code(result));
                }
              })
        ],
      ),
      body: Form(
        key: _globalKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "8 digits",
                  border: InputBorder.none,
                  counter: Offstage(),
                ),
                keyboardType: TextInputType.number,
                cursorColor: Colors.orange,
                validator: (value) => value.isEmpty ? "Required" : null,
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class _EAN8Code extends StatelessWidget {
  var result = ''.obs;
  _EAN8Code(this.result);
  GlobalKey globalKey = new GlobalKey();
  var type = "QRCODE".obs;
  var date = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now()).obs;
  int isFavourite = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "QR Scanner",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  final RenderBox box = context.findRenderObject();
                  Share.share(result.value,
                      subject: result.value,
                      sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size);
                });
          }),
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () {
              Get.to( ViewCode(
                result: result,
                type: type,
                date: date,
                isFavourite: 1,
              ));
            },
          ),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.print),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: RepaintBoundary(
                        key: globalKey,
                        child: Obx(() => SfBarcodeGenerator(
                          value: result.value,
                          symbology: EAN8(),
                          showValue: false,
                          barColor: Colors.black,
                        )),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "EAN",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Obx(() => Text(
                  result.value,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                child: Text(
                  "EAN 8",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
