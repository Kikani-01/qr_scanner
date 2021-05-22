import 'package:flutter/material.dart';

class TipForScanning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Tips for scanning",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Image(
            image: AssetImage("assets/help1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
