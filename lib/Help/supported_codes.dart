import 'package:flutter/material.dart';

class SupportedCodes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Supported codes",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image(
                image: AssetImage("assets/Supported codes/supported1.jpg"),
              ),
            ),
            Container(
              child: Image(
                image: AssetImage("assets/Supported codes/supported2.jpg"),
              ),
            ),
            Container(
              child: Image(
                image: AssetImage("assets/Supported codes/supported3.jpg"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
