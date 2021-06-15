import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qr_scann/Pages/payments/credit_or_debit.dart';
import 'package:qr_scann/Pages/payments/redeem_code.dart';

class Ads extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Pro Version",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.cyan,
                ),
                title: Text(
                  "Pro version",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                trailing: Text(
                  "₹40.00",
                  style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Features:",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.cyan,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.not_interested,
                    color: Theme.of(context).accentColor),
                title: Text("No advertising"),
              ),
              ListTile(
                leading: Icon(Icons.double_arrow_sharp,
                    color: Theme.of(context).accentColor),
                title: Text("Continuous scanning"),
              ),
              ListTile(
                leading: Icon(Icons.filter_list,
                    color: Theme.of(context).accentColor),
                title: Text("Remove duplicate barcodes"),
              ),
              ListTile(
                leading:
                    Icon(Icons.check, color: Theme.of(context).accentColor),
                title: Text("confirm scans manually"),
              ),
              ListTile(
                leading: Icon(
                  Icons.color_lens,
                  color: Theme.of(context).accentColor,
                ),
                title: Text("Additional app theme"),
              ),
              ListTile(
                leading: Icon(Icons.check_circle, color: Colors.orange),
                title: Text("one-time purchase(no subscription)"),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.cyan,
                  ),
                  child: FlatButton(
                    onPressed: () {
                      proIncnome(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "UPGRADE TO PRO VERSION",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "RESTORE PURCHASE",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "The pro version is a one-time purchase with no recurring fees. the purchase os stored in the buyer's Google account and can be used across multiple devices including future devices.",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  proIncnome(context) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Google pay"),
            ),
            Divider(),
            ListTile(
              title: Text(
                "Pro version",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("AdminGmail@gmail.com"),
              trailing: Text(
                "₹40.00",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                  "Add a payment method to your Google Account to complete your purchase. Your Payment information is only visible to Google."),
            ),
            InkWell(
              onTap: () {
                Get.to(CreditOrDebit());
              },
              child: Card(
                margin: EdgeInsets.all(10),
                color: Colors.white,
                elevation: 0.0,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Colors.grey,
                    // width: 2.0,
                  ),
                ),
                child: ListTile(
                  leading: Icon(Icons.credit_card, color: Colors.orange),
                  title: Text("Add credit or debit card"),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10),
              color: Colors.white,
              elevation: 0.0,
              shape: StadiumBorder(
                side: BorderSide(
                  color: Colors.grey,
                  // width: 2.0,
                ),
              ),
              child: ListTile(
                leading: Icon(Icons.account_balance, color: Colors.orange),
                title: Text("Add Netbanking"),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(RedeemCode());
              },
              child: Card(
                margin: EdgeInsets.all(10),
                color: Colors.white,
                elevation: 0.0,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Colors.grey,
                    // width: 2.0,
                  ),
                ),
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.googlePlay),
                  title: Text("Reddeem Code"),
                ),
              ),
            ),
          ],
        ),
      ),
      // barrierColor: Colors.black,
      backgroundColor: Colors.white,
      isDismissible: true,
      isScrollControlled: true,
    );
  }
}
