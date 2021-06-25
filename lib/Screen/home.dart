import 'package:flutter/material.dart';
import 'package:qr_scann/Layout/responsive_layout.dart';
import 'package:qr_scann/Screen/History/history.dart';

import 'Create/create.dart';
import 'Scan/scanner.dart';
import 'Settings/settings.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: ResponsiveLayout(
            tab: tablate(),
            mobile: mobile(),
          ),
        ),
        body: TabBarView(
          children: [
            Scanner(),
            Create(),
            History(),
            Settings(),
          ],
        ),
      ),
    );
  }

  Widget mobile() {
    return AppBar(
        backgroundColor: Colors.cyan,
        bottom: TabBar(
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.orange,
          tabs: <Widget>[
            Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                  ),
                  Text(
                    "Scan",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  Text(
                    "Create",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.history,
                    color: Colors.white,
                  ),
                  Text(
                    "History",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget tablate() {
    return AppBar(
        backgroundColor: Colors.cyan,
        bottom: TabBar(
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.orange,
          tabs: <Widget>[
            Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                  ),
                  Text(
                    "Scan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  Text(
                    "Create",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.history,
                    color: Colors.white,
                  ),
                  Text(
                    "History",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
