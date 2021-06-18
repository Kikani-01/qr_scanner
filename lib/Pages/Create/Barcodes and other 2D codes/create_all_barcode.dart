import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_scann/DataBase/databasehelper.dart';
import 'package:qr_scann/DataBase/getdata.dart';
import 'package:qr_scann/Pages/Create/Barcodes%20and%20other%202D%20codes/Code/code_bar.dart';
import 'package:qr_scann/Screen/Create/create_all_result.dart';
import 'package:share/share.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateAllBarcodes extends StatelessWidget {
  var result;
  final String type;
  final String category;
  CreateAllBarcodes(this.result, this.type, this.category);
  GlobalKey globalKey = new GlobalKey();
  var date = DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.now());
  final TextEditingController _textController = TextEditingController();

  checkType(String test) {
    switch (test) {
      case "Qr code":
        {
          return QRCode();
        }
        break;
      case "code 39":
        {
          return Code39();
        }
        break;
      case "code 93":
        {
          return Code93();
        }
        break;
      case "code 128":
        {
          return Code128();
        }
        break;
      case "code bar":
        {
          return CODEBar();
        }
        break;
      case "Data matrix":
        {
          return DataMatrix();
        }
        break;
      case "EAN 8":
        {
          return EAN8();
        }
        break;
      case "EAN 13":
        {
          return EAN13();
        }
        break;
      case "code bar":
        {
          return CODEBar();
        }
        break;
      case "Contact":
        {
          return QRCode();
        }
        break;

      default:
        {
          return QRCode();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    save();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          category,
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
            width: 10,
          ),
          Icon(Icons.print),
          SizedBox(
            width: 10,
          ),
          popMenu(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
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
                        value: result,
                        symbology: checkType(type),
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
              child: GestureDetector(
                child: Text(
                  result,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  customLaunch(result);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                type,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                bottom: 20.0,
              ),
              child: Text(
                date,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            InkWell(
              highlightColor: Colors.orange,
              splashColor: Colors.orange[200],
              onTap: () {
                Get.to(CreateAllResult(result, category, date));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                child: Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        FontAwesomeIcons.barcode,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 23,
                    ),
                    Text(
                      "View code",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.star_border),
                            onPressed: () {
                              // favourite();
                            }),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            showAlertDialog();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.copy),
                          onPressed: () {
                            copyClipboard();
                          },
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  Icons.open_in_browser,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              title: Text(
                "Open website",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
                customLaunch(result);
              },
            ),
          ],
        ),
      ),
    );
  }

  MenuOption select;

  Widget popMenu() {
    return PopupMenuButton<MenuOption>(
      onSelected: (MenuOption result) {
        select = result;
        switch (select) {
          case MenuOption.Favorites:
            {
              // favourite();
            }
            break;
          case MenuOption.Notes:
            {
              showAlertDialog();
            }
            break;
          case MenuOption.Copy:
            {
              copyClipboard();
            }
            break;
        }
      },
      icon: Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      itemBuilder: (context) => <PopupMenuEntry<MenuOption>>[
        PopupMenuItem(
          child: Text("Favorites"),
          value: MenuOption.Favorites,
        ),
        PopupMenuItem(
          child: Text("Notes"),
          value: MenuOption.Notes,
        ),
        PopupMenuItem(
          child: Text("Copy Code"),
          value: MenuOption.Copy,
        )
      ],
    );
  }

  void copyClipboard() {
    Get.snackbar("Copied", "Copied to clipboard",
        margin: EdgeInsets.all(10), snackPosition: SnackPosition.BOTTOM);
    Clipboard.setData(new ClipboardData(text: result));
  }

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print("Could not launch $command ");
    }
  }

  showAlertDialog() {
    Get.defaultDialog(
      content: TextFormField(
        controller: _textController,
        validator: (value) => value.isEmpty ? "Required" : null,
        decoration: InputDecoration(
          hintText: "Notes",
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
        ),
        cursorColor: Colors.orange,
      ),
      onConfirm: () {},
      textConfirm: 'OK',
      onCancel: () {
        Get.back();
      },
      textCancel: 'Cancel',
    );
  }

  void save() async {
    DatabaseHelper helper = DatabaseHelper();
    Databasedata databasedata = Databasedata();
    databasedata.saveResult = result.toString();
    databasedata.date = date.toString();
    databasedata.isFavourite = 1;
    var save;
    if (databasedata.id != null) {
      save = await helper.updateNote(databasedata);
    } else {
      save = await helper.insertNote(databasedata);
    }
    print("++");
  }
}

enum MenuOption {
  Favorites,
  Notes,
  Copy,
}
