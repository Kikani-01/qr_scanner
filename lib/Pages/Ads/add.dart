import 'package:flutter/material.dart';

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
                    onPressed: () {},
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
}
