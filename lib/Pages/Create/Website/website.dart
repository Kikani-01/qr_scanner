import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scann/Pages/Create/Barcodes%20and%20other%202D%20codes/create_all_barcode.dart';
import 'package:qr_scann/Screen/Create/share.dart';

class WebSite extends StatelessWidget {
  var dataString;
  TextEditingController _textController =
      TextEditingController(text: "https://");
  TextStyle style = TextStyle(
    fontSize: 20.0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Website',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.check,
              ),
              onPressed: () {
                Get.to(CreateAllBarcodes(
                    _textController.text.toString(), 'Website', "QR Code"));
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _textController,
                validator: (value) =>
                    _textController == null ? "please enter Url" : null,
                decoration: InputDecoration(
                  hintText: "URL",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10),
              child: Text("Alternatively:", style: style),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10),
              child: Text("   •  Open your browser app.", style: style),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10),
              child: Text("   •  Load your website.", style: style),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10),
              child: Text("   •  Select 'Share' from the menu.", style: style),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10),
              child: Text("   •  Select 'QR Scanner'.", style: style),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 13.0, left: 10),
                  child: Text(
                    "Also see.",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(ShareExmaple());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 13.0),
                    child: Text(
                      "Use'Share' in other apps.",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
