import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Code/code39.dart';
import 'Code/code_128.dart';
import 'Code/code_93.dart';
import 'Code/code_bar.dart';
import 'Data Matrix/data_matrix.dart';
import 'EAN/ean_13.dart';
import 'EAN/ean_8.dart';
import 'QR Code/qr_code.dart';
import 'UPC/upc_a.dart';
import 'UPC/upc_e.dart';

class BarcodesAnd2DCodes extends StatelessWidget {
  var result = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Barcodes and other 2D codes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.qr_code,
                  color: Colors.white,
                ),
                backgroundColor: Colors.orange,
              ),
              title: Text("QR Code"),
              subtitle: Text("text"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => QRCODE()));
              },
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DataMatrixCode()));
              },
              leading: CircleAvatar(
                child: Icon(
                  Icons.qr_code_scanner_rounded,
                  color: Colors.white,
                ),
                backgroundColor: Colors.orange,
              ),
              title: Text("Data Matrix"),
              subtitle: Text("text without special characters"),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  FontAwesomeIcons.qrcode,
                  color: Colors.white,
                ),
                backgroundColor: Colors.orange,
              ),
              title: Text("EAN 13"),
              subtitle: Text("12 digits + 1 checksum digit"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EAN13Code()));
              },
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  FontAwesomeIcons.barcode,
                  color: Colors.white,
                ),
                backgroundColor: Colors.orange,
              ),
              title: Text("EAN 8"),
              subtitle: Text("8 digits"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EAN8Code()));
              },
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  FontAwesomeIcons.barcode,
                  color: Colors.white,
                ),
                backgroundColor: Colors.orange,
              ),
              title: Text("UPC E"),
              subtitle: Text("8 digits"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UPCECode()));
              },
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  FontAwesomeIcons.barcode,
                  color: Colors.white,
                ),
                backgroundColor: Colors.orange,
              ),
              title: Text("UPC A"),
              subtitle: Text("11 digits + 1 checksum digit"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UPCACode()));
              },
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  FontAwesomeIcons.barcode,
                  color: Colors.white,
                ),
                backgroundColor: Colors.orange,
              ),
              title: Text("Code 128"),
              subtitle: Text("text without special characters"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CODE128()));
              },
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  FontAwesomeIcons.barcode,
                  color: Colors.white,
                ),
                backgroundColor: Colors.orange,
              ),
              title: Text("Code 93"),
              subtitle: Text("text in upper case without special characters"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => CODE93()));
              },
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  FontAwesomeIcons.barcode,
                  color: Colors.white,
                ),
                backgroundColor: Colors.orange,
              ),
              title: Text("Code 39"),
              subtitle: Text("text in upper case without special characters"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => CODE39()));
              },
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(
                  FontAwesomeIcons.barcode,
                  color: Colors.white,
                ),
                backgroundColor: Colors.orange,
              ),
              title: Text("Codabar"),
              subtitle: Text("digits"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CODEBar()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
