import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FAQ extends StatelessWidget {
  RxBool first = false.obs;
  RxBool second = false.obs;
  RxBool third = false.obs;
  RxBool fourth = false.obs;
  RxBool five = false.obs;
  RxBool six = false.obs;
  RxBool seven = false.obs;
  RxBool eight = false.obs;
  RxBool nine = false.obs;
  RxBool ten = false.obs;
  RxBool eleven = false.obs;

  var widgetText = TextStyle(
    color: Colors.grey,
    fontSize: 15,
  );

  var textstyle = TextStyle(
    fontSize: 17,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "FAQ",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Obx(
            () => Column(
              children: [
                Column(
                  children: [
                    ListTile(
                      leading: first.value
                          ? Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.orange,
                              size: 25,
                            )
                          : Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.orange,
                              size: 25,
                            ),
                      title: Text(
                        "How do I get a refund for my purchase?",
                        style: textstyle,
                      ),
                      onTap: () {
                        first.value = !first.value;
                      },
                    ),
                    if (first.value) firstView(),
                    Divider(),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: second.value
                          ? Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.orange,
                              size: 25,
                            )
                          : Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.orange,
                              size: 25,
                            ),
                      title: Text(
                        "How can I see prices when scanning a barcode?",
                        style: textstyle,
                      ),
                      onTap: () {
                        second.value = !second.value;
                      },
                    ),
                    if (second.value) secondView(),
                    Divider(),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: third.value
                          ? Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.orange,
                              size: 25,
                            )
                          : Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.orange,
                              size: 25,
                            ),
                      title: Text(
                        "why does the QR code not work?",
                        style: textstyle,
                      ),
                      onTap: () {
                        third.value = !third.value;
                      },
                    ),
                    if (third.value) thirdView(),
                    Divider(),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: fourth.value
                          ? Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.orange,
                              size: 25,
                            )
                          : Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.orange,
                              size: 25,
                            ),
                      title: Text(
                        "The scan result of a product barcode indicates\na country. How does this work?",
                        style: textstyle,
                      ),
                      onTap: () {
                        fourth.value = !fourth.value;
                      },
                    ),
                    if (fourth.value) fourthView(),
                    Divider(),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: five.value
                          ? Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.orange,
                              size: 25,
                            )
                          : Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.orange,
                              size: 25,
                            ),
                      title: Text(
                        "Can I improve the quality of the translation?",
                        style: textstyle,
                      ),
                      onTap: () {
                        five.value = !five.value;
                      },
                    ),
                    if (five.value) fiveView(),
                    Divider(),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: six.value
                          ? Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.orange,
                              size: 25,
                            )
                          : Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.orange,
                              size: 25,
                            ),
                      title: Text("Can I scan a ccode within a PDF?",
                          style: textstyle),
                      onTap: () {
                        six.value = !six.value;
                      },
                    ),
                    if (six.value) sixView(),
                    Divider(),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: seven.value
                          ? Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.orange,
                              size: 25,
                            )
                          : Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.orange,
                              size: 25,
                            ),
                      onTap: () {
                        seven.value = !seven.value;
                      },
                      title: Text("Does the app have an API or similar?",
                          style: textstyle),
                    ),
                    if (seven.value) sevenView(),
                    Divider(),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: eight.value
                          ? Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.orange,
                              size: 25,
                            )
                          : Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.orange,
                              size: 25,
                            ),
                      title: Text(
                          "Do you offer an SDK for developing barcode scanner apps?",
                          style: textstyle),
                      onTap: () {
                        eight.value = !eight.value;
                      },
                    ),
                    if (eight.value) eightView(),
                    Divider(),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: nine.value
                          ? Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.orange,
                              size: 25,
                            )
                          : Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.orange,
                              size: 25,
                            ),
                      title: Text(
                        "Can I get a customised version of the app for my business?",
                        style: textstyle,
                      ),
                      onTap: () {
                        nine.value = !nine.value;
                      },
                    ),
                    if (nine.value) nineView(),
                    Divider(),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: ten.value
                          ? Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.orange,
                              size: 25,
                            )
                          : Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.orange,
                              size: 25,
                            ),
                      title: Text("What are 'Crome Custom Tabs'?",
                          style: textstyle),
                      onTap: () {
                        ten.value = !ten.value;
                      },
                    ),
                    if (ten.value) tenView(),
                    Divider(),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      leading: eleven.value
                          ? Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.orange,
                              size: 25,
                            )
                          : Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.orange,
                              size: 25,
                            ),
                      title: Text(
                          "Why three different scanner apps on Google Play?",
                          style: textstyle),
                      onTap: () {
                        eleven.value = !eleven.value;
                      },
                    ),
                    if (eleven.value) elevenView(),
                    Divider(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget firstView() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Please note that the 'Pro version' is a one-time purchase.\n"
            "If you have been billed for a subscription, it is likely from another QR scanner app with the same name.\n"
            "For example, the QR scanner by the developer named 'Macland Group' contains a subscription.",
            style: widgetText,
          ),
        ],
      ),
    );
  }

  Widget secondView() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Some website like eBay.com give us access to their product and pricing information. \n"
              "In that case, we can display the prices directly in the app.\n"
              "This works best in the Us with popular product like books.\n"
              "If it does not work: The button 'Search product on the web' ",
              style: widgetText),
        ],
      ),
    );
  }

  Widget thirdView() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Sometimes, a QR code contains a website link.If the website does not work, only the company which owns the website (and probably created the QR code) can fix that.Unfortunately, there is nothing we can do here.",
              style: widgetText),
        ],
      ),
    );
  }

  Widget fourthView() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "The first three digits of an EAN-13 (GS1 prefix) usually identify the country of the GS1 member organization that the manufacture has joined. This is not necessarily the country where the product is actually made.",
              style: widgetText),
        ],
      ),
    );
  }

  Widget fiveView() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Yes! We really appreciate your help in improving the translation of the app into your native language.Just contact us using the 'send us an email' button and left us khown what you would like to change.",
              style: widgetText),
        ],
      ),
    );
  }

  Widget sixView() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Yes, it work like this:Open the PDF and take a screenshot using the default screenshot functionality in Android Then Scan the screenshot. For example, the QR scanner by the developer named 'Macland Group' contains a subscription.",
            style: widgetText,
          ),
        ],
      ),
    );
  }

  Widget sevenView() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Our QR scanner can be launched from other  apps and websites via programing interfaces.",
            style: widgetText,
          ),
        ],
      ),
    );
  }

  Widget eightView() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 8.0),
      child: Column(
        children: [
          Text(
            "no",
            style: widgetText,
          ),
        ],
      ),
    );
  }

  Widget nineView() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 8.0),
      child: Column(
        children: [
          Text("Unfortunately we don't do any customer-specific developments.",
              style: widgetText),
        ],
      ),
    );
  }

  Widget tenView() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 8.0),
      child: Column(
        children: [
          Text(
              "By providing a service to other apps Chrome lets other apps display Web content faster.",
              style: widgetText),
        ],
      ),
    );
  }

  Widget elevenView() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 8.0),
      child: Column(
        children: [
          Text(
              "Technically, all apps are identical and they will all the updates in the future. Only the branding is diffrent and the way to upgrade to 'Pro version'.",
              style: widgetText),
        ],
      ),
    );
  }
}
