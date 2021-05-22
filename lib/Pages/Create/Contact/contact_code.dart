import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCode extends StatelessWidget {
  GlobalKey globalKey = new GlobalKey();
  var result = "result";
  var firstName;
  var lastName;
  var company;
  var jobTitle;
  var phoneNumber;
  var email;
  var streetAddress;
  var postcode;
  var city;
  var region;
  var country;
  var website;
  var notes;
  var type;
  var date;
  ContactCode(
    this.firstName,
    this.lastName,
    this.company,
    this.jobTitle,
    this.phoneNumber,
    this.email,
    this.streetAddress,
    this.postcode,
    this.city,
    this.region,
    this.country,
    this.website,
    this.notes,
    this.type,
    this.date,
  );

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print("Could not launch $command ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          type,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  final RenderBox box = context.findRenderObject();
                  Share.share(result,
                      subject: result,
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size);
                });
          }),
          SizedBox(
            width: 15,
          ),
          Icon(Icons.print),
          SizedBox(
            width: 15,
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
                  height: MediaQuery.of(context).size.height * 0.5,
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
                        child: SfBarcodeGenerator(
                          value:
                              '''$firstName $lastName $company $jobTitle $phoneNumber $email $streetAddress $postcode $city $region $country $website $notes''',
                          symbology: QRCode(),
                          showValue: false,
                          barColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    firstName != null ? Text(firstName) : SizedBox(),
                    lastName != null ? Text(lastName) : SizedBox(),
                    company != null ? Text(company) : SizedBox(),
                    jobTitle != null ? Text(jobTitle) : SizedBox(),
                    phoneNumber != null ? Text(phoneNumber) : SizedBox(),
                    email != null ? Text(email) : SizedBox(),
                    streetAddress != null ? Text(streetAddress) : SizedBox(),
                    postcode != null ? Text(postcode) : SizedBox(),
                    city != null ? Text(city) : null,
                    region != null ? Text(region) : null,
                    country != null ? Text(country) : null,
                    website != null ? Text(website) : null,
                    notes != null ? Text(notes) : null,
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                child: Text(
                  type,
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

  resultString() {
    var resultString =
        '''$firstName\n$lastName\n$company\n$jobTitle\n$phoneNumber\n$email\n$streetAddress\n$postcode\n$city\n$region\n$country\n$website\n$notes''';

    return resultString;
  }
}
