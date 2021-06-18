import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scann/Pages/Create/Barcodes%20and%20other%202D%20codes/create_all_barcode.dart';

class UPCECode extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  var _globalKey = GlobalKey<FormState>();
  var result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "UPC E",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                this.result = controller.text;
                if (_globalKey.currentState.validate()) {
                  Get.to(CreateAllBarcodes(result, "UPC E", "UPC"));
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
                  maxLength: 8,
                  cursorColor: Colors.orange,
                  validator: (value) => value.isEmpty ? "Required" : null,
                  keyboardType: TextInputType.number),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
