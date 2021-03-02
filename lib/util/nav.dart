import 'package:flutter/material.dart';

class Nav {
  static push(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  static pushFullScreenDialog(BuildContext context, Widget page) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => page, fullscreenDialog: true));
  }

  static pushAndReplace(BuildContext context, Widget page) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  static pop(BuildContext context) => Navigator.of(context).pop();
}
