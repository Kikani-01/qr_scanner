import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_scann/Screen/Create/share.dart';
import 'contact_code.dart';

class Contact extends StatelessWidget {
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController company = new TextEditingController();
  TextEditingController jobTitle = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController streetAddress = new TextEditingController();
  TextEditingController postcode = new TextEditingController();
  TextEditingController city = new TextEditingController();
  TextEditingController region = new TextEditingController();
  TextEditingController country = new TextEditingController();
  TextEditingController website = new TextEditingController();
  TextEditingController notes = new TextEditingController();
  var type = "Contact";
  var date = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
  int isFavourite = 1;
  var _key = GlobalKey<FormState>();

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
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                if (_key.currentState.validate()) {
                  Get.to(ContactCode(
                    this.firstName.text.toString(),
                    this.lastName.text.toString(),
                    this.company.text.toString(),
                    this.jobTitle.text.toString(),
                    this.phoneNumber.text.toString(),
                    this.email.text.toString(),
                    this.streetAddress.text.toString(),
                    this.postcode.text.toString(),
                    this.city.text.toString(),
                    this.region.text.toString(),
                    this.country.text.toString(),
                    this.website.text.toString(),
                    this.notes.text.toString(),
                    this.type,
                    this.date,
                  ));
                }
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: TextFormField(
                        controller: firstName,
                        cursorColor: Colors.orange,
                        decoration: InputDecoration(
                          hintText: "First name",
                          border: InputBorder.none,
                        ),
                        validator: (value) =>
                            value.isEmpty ? "First name is Required" : null,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        controller: lastName,
                        cursorColor: Colors.orange,
                        decoration: InputDecoration(
                          hintText: "Last name",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: TextFormField(
                        controller: company,
                        cursorColor: Colors.orange,
                        decoration: InputDecoration(
                          hintText: "Company",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        controller: jobTitle,
                        cursorColor: Colors.orange,
                        decoration: InputDecoration(
                          hintText: "Job title",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                  ),
                  child: TextFormField(
                    controller: phoneNumber,
                    cursorColor: Colors.orange,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Phone number",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              Divider(),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                  ),
                  child: TextFormField(
                    cursorColor: Colors.orange,
                    controller: email,
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              Divider(),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                  ),
                  child: TextFormField(
                    controller: streetAddress,
                    cursorColor: Colors.orange,
                    decoration: InputDecoration(
                      hintText: "Street address",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              Divider(),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: TextFormField(
                        controller: postcode,
                        cursorColor: Colors.orange,
                        decoration: InputDecoration(
                          hintText: "Postcode",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        controller: city,
                        cursorColor: Colors.orange,
                        decoration: InputDecoration(
                          hintText: "City",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: TextFormField(
                        controller: region,
                        cursorColor: Colors.orange,
                        decoration: InputDecoration(
                          hintText: "Region",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        controller: country,
                        cursorColor: Colors.orange,
                        decoration: InputDecoration(
                          hintText: "Country",
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                  ),
                  child: TextFormField(
                    controller: website,
                    cursorColor: Colors.orange,
                    decoration: InputDecoration(
                      hintText: "Website",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              Divider(),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                  ),
                  child: TextFormField(
                    controller: notes,
                    cursorColor: Colors.orange,
                    decoration: InputDecoration(
                      hintText: "Notes",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              Divider(),
              // Alternatively
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10),
                child: Text(
                  "Alternatively:",
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10),
                child: Text(
                  "   •  Open your browser app.",
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10),
                child: Text(
                  "   •  Load your website.",
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10),
                child: Text(
                  "   •  Select 'Share' from the menu.",
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 10, bottom: 20.0),
                child: Text(
                  "   •  Select 'QR Scanner'.",
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Text(
                      "Also see.",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(ShareExmaple());
                      },
                      child: Text(
                        "Use'Share' in other apps.",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
