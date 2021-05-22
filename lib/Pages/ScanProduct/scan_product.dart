import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:qr_scann/Screen/home.dart';

class ScanProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScanProductState();
  }
}

class ScanProductState extends State<ScanProduct> {
  @override
  Widget build(BuildContext context) {
    print("Scan Product");
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Scan product barcode",
            body: "Find out more about product's origin",
            image: buildImage("assets/Onboarding_screen/Scan.png"),
            decoration: getPageDecoarion(),
          ),
          PageViewModel(
            title: "Learn how to Scan properly",
            body:
                "Read the app's to avoid comman mistakes when scanning barcodes",
            image: buildImage("assets/Onboarding_screen/info.png"),
            decoration: getPageDecoarion(),
          ),
          PageViewModel(
            title: "Learn how to Scan properly",
            body:
                "Read the app's to avoid comman mistakes when scanning barcodes",
            image: buildImage("assets/Onboarding_screen/Setting.png"),
            decoration: getPageDecoarion(),
          ),
        ],
        done: Text(
          "Done",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        onDone: () => goToHome(context),
        showSkipButton: true,
        skip: Text(
          "Skip",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        onSkip: () => goToHome(context),
        next: Icon(Icons.arrow_forward_sharp),
        dotsDecorator: getDotDecoration(),
        globalBackgroundColor: Colors.cyan,
        isProgressTap: false,
        animationDuration: 500,
      ),
    );
  }

  void goToHome(context) => Get.off(Home());
  Widget buildImage(String path) => Center(
        child: Image.asset(
          path,
          width: 250,
          color: Colors.black,
        ),
      );

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Colors.white,
        activeColor: Colors.black,
        size: Size(10, 10),
        activeSize: Size(15, 10),
      );

  PageDecoration getPageDecoarion() => PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 15, color: Colors.white),
        descriptionPadding: EdgeInsets.all(30),
        imagePadding: EdgeInsets.all(20),
        pageColor: Colors.cyan,
      );
}
