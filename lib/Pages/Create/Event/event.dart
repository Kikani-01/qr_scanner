import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_scann/Screen/Create/create_all_result.dart';

class Event extends StatelessWidget {
  DateTime _startDate;
  DateTime _endDate;
  var result;
  var date = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
  var type = "Event";
  var _key = GlobalKey<FormState>();
  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController discription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          type,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                this.result = contactString();
                if (_key.currentState.validate()) {
                  Get.to(CreateAllResult(result, type, date));
                }
              })
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: TextFormField(
                    cursorColor: Colors.orange,
                    controller: title,
                    decoration: InputDecoration(
                      hintText: "Event title",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    validator: (value) =>
                        value.isEmpty ? "title is null" : null,
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: InkWell(
                    onTap: () {
                      print("ERROR");
                      _selectStartDate(context);
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        validator: (value) =>
                            value.isEmpty ? "Start date is null" : null,
                        controller: start,
                        cursorColor: Colors.orange,
                        decoration: InputDecoration(
                          hintText: "Start Date",
                          counter: Offstage(),
                          border: InputBorder.none,
                        ),
                        focusNode: AlwaysDisabledFocusNode(),
                      ),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: InkWell(
                    onTap: () {
                      print("ERROR");
                      _selectEndDate(context);
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: end,

                        focusNode: AlwaysDisabledFocusNode(),
                        cursorColor: Colors.orange,
                        validator: (value) =>
                            value.isEmpty ? "End date is null" : null,
                        decoration: InputDecoration(
                          hintText: "End Date",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: TextFormField(
                    cursorColor: Colors.orange,
                    controller: location,
                    decoration: InputDecoration(
                      hintText: "Event location",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: TextFormField(
                    cursorColor: Colors.orange,
                    controller: discription,
                    decoration: InputDecoration(
                      hintText: "Description",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectStartDate(BuildContext context) async {
     DateTime newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _startDate != null ? _startDate : DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2050),
    );
    if (newSelectedDate != null) {
      _startDate = newSelectedDate;
      start
        ..text = DateFormat('dd-MM-yyyy').format(_startDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: start.text.length, affinity: TextAffinity.upstream));
    }
  }

  _selectEndDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _endDate != null ? _endDate : DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2050),
    );

    if (newSelectedDate != null) {
      _endDate = newSelectedDate;
      end
        ..text = DateFormat('dd-MM-yyyy').format(_endDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: end.text.length, affinity: TextAffinity.upstream));
    }
  }

  contactString() {
    String firstName = this.start.text.toString();
    String lastName = this.end.text.toString();
    String title = this.title.text.toString();
    String location = this.location.text.toString();
    String discription = this.discription.text.toString();

    return '''
  $title
  $firstName
  $lastName
  $location
  $discription
   ''';
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
