import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget tab;
  final Widget mobile;

  const ResponsiveLayout({Key key, this.tab, this.mobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 450) {
        return mobile;
      } else {
        return tab;
      }
    });
  }
}
